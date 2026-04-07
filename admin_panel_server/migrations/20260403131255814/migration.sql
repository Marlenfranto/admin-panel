BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_theory_progress" (
    "id" bigserial PRIMARY KEY,
    "appUserId" bigint NOT NULL,
    "organizationId" bigint NOT NULL,
    "chapterId" bigint NOT NULL,
    "score" bigint NOT NULL,
    "status" text NOT NULL,
    "lastWatchedPosition" bigint,
    "completedAt" timestamp without time zone
);


--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260403131255814', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260403131255814', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20260129181059877', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181059877', "timestamp" = now();


COMMIT;
