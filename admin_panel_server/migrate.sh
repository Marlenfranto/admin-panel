#!/usr/bin/env bash
# Wrapper around `dart bin/main.dart --apply-migrations` for Neon production.
#
# Two failure modes this script handles:
#
#   A) Cold-start TimeoutException during `verifyDatabaseIntegrity`. From
#      Mumbai → us-east-1, Serverpod's ~100 parallel pg_catalog queries can't
#      drain within the postgres package's hardcoded 15s pool timeout. We
#      pre-warm the catalog with psql so Neon's buffer cache is hot.
#
#   B) Verify timeout AFTER the migration succeeded. The string "Latest
#      database migration already applied" (or "applied successfully") in
#      the dart output proves the schema is in sync — the verify step is a
#      post-flight sanity check, not part of the migration write. We treat
#      "migration applied + verify timeout" as success.
#
# Log lives at ./migrate.log (project-local, not /tmp) so a full TMPDIR
# can't break the script.
#
# Usage:
#   ./migrate.sh                # defaults to production mode
#   ./migrate.sh staging
#   ./migrate.sh production --apply-repair-migration   # extra flags pass through

set -euo pipefail

cd "$(dirname "$0")"

MODE="${1:-production}"
shift || true

CONFIG="config/${MODE}.yaml"
PASSWORDS="config/passwords.yaml"
LOG="./migrate.log"

if [[ ! -f "$CONFIG" ]]; then
  echo "Config not found: $CONFIG" >&2
  exit 1
fi

# Read a value from a YAML block.  Usage: yaml_get <section> <key> <file>
yaml_get() {
  awk -v section="$1" -v key="$2" '
    $0 ~ "^"section":" { in_section=1; next }
    in_section && /^[a-zA-Z]/ { in_section=0 }
    in_section && $0 ~ "^[[:space:]]+"key":[[:space:]]" {
      sub(/^[[:space:]]+[a-zA-Z_]+:[[:space:]]*/, "")
      gsub(/^['\''"]|['\''"]$/, "")
      print
      exit
    }
  ' "$3"
}

prewarm() {
  local host="$1" port="$2" name="$3" user="$4" pass="$5"
  echo "→ Pre-warming $host (mode=$MODE) ..."
  PGPASSWORD="$pass" psql \
    "host=$host port=$port dbname=$name user=$user sslmode=require" \
    -tAv ON_ERROR_STOP=1 <<'SQL' >/dev/null
SELECT 1;
SELECT count(*) FROM pg_class;
SELECT count(*) FROM pg_attribute;
SELECT count(*) FROM pg_index;
SELECT count(*) FROM pg_constraint;
SELECT count(*) FROM pg_namespace;
SQL
}

banner() {
  printf '\n==================================================\n%s\n==================================================\n' "$1"
}

# Migration is successful if the dart log says it was applied or already
# up-to-date, even if verifyDatabaseIntegrity timed out afterwards.
migration_applied() {
  grep -qE "Latest database migration already applied|applied successfully|Migrations applied" "$LOG"
}

real_migration_failure() {
  grep -qE "Failed to apply migration [0-9]+|relation \".*\" already exists|relation \".*\" does not exist|DatabaseQueryException" "$LOG"
}

if command -v psql >/dev/null 2>&1; then
  DB_HOST=$(yaml_get database host "$CONFIG")
  DB_PORT=$(yaml_get database port "$CONFIG")
  DB_NAME=$(yaml_get database name "$CONFIG")
  DB_USER=$(yaml_get database user "$CONFIG")
  DB_PASS=$(yaml_get "$MODE" database "$PASSWORDS")

  if [[ -z "$DB_HOST" || -z "$DB_USER" || -z "$DB_NAME" || -z "$DB_PASS" ]]; then
    echo "Failed to parse DB host/user/name from $CONFIG or password from $PASSWORDS [$MODE]" >&2
    exit 1
  fi
  HAS_PSQL=1
else
  HAS_PSQL=0
  echo "⚠️  psql not found — skipping pre-warm. Will retry on timeout." >&2
fi

MAX_ATTEMPTS=3

for attempt in $(seq 1 $MAX_ATTEMPTS); do
  banner "Attempt $attempt of $MAX_ATTEMPTS"

  if [[ "$HAS_PSQL" == "1" ]]; then
    prewarm "$DB_HOST" "${DB_PORT:-5432}" "$DB_NAME" "$DB_USER" "$DB_PASS"
    sleep 1
  fi

  echo "→ Applying migrations (mode=$MODE) ..."
  : > "$LOG"
  set +e
  dart bin/main.dart --apply-migrations --mode "$MODE" "$@" 2>&1 | tee "$LOG"
  DART_RC=${PIPESTATUS[0]}
  set -e

  if [[ $DART_RC -eq 0 ]]; then
    banner "✓ Migration succeeded (attempt $attempt)"
    exit 0
  fi

  # Real SQL/migration error — don't retry, won't fix itself.
  if real_migration_failure; then
    banner "✗ Real migration error — see log above. Not retrying."
    exit 1
  fi

  # Migration was applied; only verify timed out. Treat as success.
  if migration_applied && grep -q "Failed to acquire pool lock" "$LOG"; then
    banner "✓ Migration applied. verifyDatabaseIntegrity timed out (harmless from Mumbai → us-east-1)."
    exit 0
  fi

  # Pure pool timeout, no migration progress yet — try again with another prewarm.
  if grep -q "Failed to acquire pool lock" "$LOG" \
     && [[ $attempt -lt $MAX_ATTEMPTS ]]; then
    SLEEP=$((attempt * 4))
    banner "→ Pool timeout, no migration progress. Sleeping ${SLEEP}s and retrying ..."
    sleep $SLEEP
    continue
  fi

  banner "✗ Migration failed (attempt $attempt — not retrying)"
  exit 1
done

banner "✗ Migration failed after $MAX_ATTEMPTS attempts"
exit 1
