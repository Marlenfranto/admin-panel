import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

final RegExp _localeKeyRe = RegExp(r'^[A-Z]{2}-[a-z]{2,3}$');

/// Returns true if [key] matches the canonical `REGION-language` format.
/// Null or non-matching values return false (no throw). Use this to skip
/// legacy pre-Phase-2 rows whose `localeKey` was just the language code.
bool isValidLocaleKeyFormat(String? key) =>
    key != null && _localeKeyRe.hasMatch(key);

/// Throws if [key] does not match the canonical `REGION-language` format.
/// Valid: `US-en`, `UK-en`, `AE-ar`. Invalid: `english-us`, `us-EN`, `enUS`.
void validateLocaleKeyFormat(String key) {
  if (!_localeKeyRe.hasMatch(key)) {
    throw Exception(
      'Invalid locale key "$key". Expected REGION-language '
      '(e.g., US-en, UK-en, AE-ar).',
    );
  }
}

/// Throws if [localeKey] does not match `regionCode-languageCode` exactly.
void validateLocaleKeyComposition(
  String localeKey,
  String regionCode,
  String languageCode,
) {
  validateLocaleKeyFormat(localeKey);
  final expected = '$regionCode-$languageCode';
  if (localeKey != expected) {
    throw Exception(
      'Locale key "$localeKey" does not match composition "$expected".',
    );
  }
}

/// Throws if [regionCode] is not a row in `region` for [organizationId].
Future<void> ensureRegionExists(
  Session session,
  int organizationId,
  String regionCode,
) async {
  final region = await Region.db.findFirstRow(
    session,
    where: (r) =>
        r.organizationId.equals(organizationId) & r.code.equals(regionCode),
  );
  if (region == null) {
    throw Exception(
      'Region "$regionCode" is not configured for this organization.',
    );
  }
}

/// Throws if [localeKey] is not a configured (enabled) LocaleConfig for
/// [organizationId]. Used as a guard before writing a localization row.
Future<void> ensureLocaleConfigured(
  Session session,
  int organizationId,
  String localeKey,
) async {
  validateLocaleKeyFormat(localeKey);
  final lc = await LocaleConfig.db.findFirstRow(
    session,
    where: (l) =>
        l.organizationId.equals(organizationId) &
        l.localeKey.equals(localeKey),
  );
  if (lc == null) {
    throw Exception(
      'Locale "$localeKey" is not configured for this organization. '
      'Add it under Locale Management first.',
    );
  }
}
