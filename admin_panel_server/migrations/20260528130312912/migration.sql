BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "assessment_parameter" DROP COLUMN "name";
ALTER TABLE "assessment_parameter" DROP COLUMN "description";
ALTER TABLE "assessment_parameter" DROP COLUMN "translations";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "asset" DROP COLUMN "name";
ALTER TABLE "asset" DROP COLUMN "url";
ALTER TABLE "asset" DROP COLUMN "description";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "module_config" DROP COLUMN "defaultLanguage";
ALTER TABLE "module_config" DROP COLUMN "supportedLanguages";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "theory_chapter" DROP COLUMN "title";
ALTER TABLE "theory_chapter" DROP COLUMN "thumbnailUrl";
ALTER TABLE "theory_chapter" DROP COLUMN "videoUrl";
ALTER TABLE "theory_chapter" DROP COLUMN "videoMetadata";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "training_parameter" DROP COLUMN "name";
ALTER TABLE "training_parameter" DROP COLUMN "description";
ALTER TABLE "training_parameter" DROP COLUMN "translations";

--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260528130312912', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260528130312912', "timestamp" = now();

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
