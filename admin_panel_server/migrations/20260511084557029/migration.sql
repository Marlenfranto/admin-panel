BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "assessment_parameter" ADD COLUMN "translations" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "module_config" ADD COLUMN "aiChatPromptTranslations" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "training_parameter" ADD COLUMN "translations" json;

--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260511084557029', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260511084557029', "timestamp" = now();

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
