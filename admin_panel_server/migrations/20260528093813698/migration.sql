BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "assessment_parameter_localization" (
    "id" bigserial PRIMARY KEY,
    "parameterId" bigint NOT NULL,
    "localeKey" text NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "scoringFeedbacks" json
);

-- Indexes
CREATE UNIQUE INDEX "assessment_param_loc_unique_idx" ON "assessment_parameter_localization" USING btree ("parameterId", "localeKey");
CREATE INDEX "assessment_param_loc_locale_idx" ON "assessment_parameter_localization" USING btree ("localeKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "asset_localization" (
    "id" bigserial PRIMARY KEY,
    "assetId" bigint NOT NULL,
    "localeKey" text NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "url" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "asset_loc_unique_idx" ON "asset_localization" USING btree ("assetId", "localeKey");
CREATE INDEX "asset_loc_locale_idx" ON "asset_localization" USING btree ("localeKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "theory_chapter_localization" (
    "id" bigserial PRIMARY KEY,
    "chapterId" bigint NOT NULL,
    "localeKey" text NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "thumbnailUrl" text,
    "videoUrl" text,
    "videoMetadata" json
);

-- Indexes
CREATE UNIQUE INDEX "theory_chapter_loc_unique_idx" ON "theory_chapter_localization" USING btree ("chapterId", "localeKey");
CREATE INDEX "theory_chapter_loc_locale_idx" ON "theory_chapter_localization" USING btree ("localeKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "training_parameter_localization" (
    "id" bigserial PRIMARY KEY,
    "parameterId" bigint NOT NULL,
    "localeKey" text NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "scoringFeedbacks" json
);

-- Indexes
CREATE UNIQUE INDEX "training_param_loc_unique_idx" ON "training_parameter_localization" USING btree ("parameterId", "localeKey");
CREATE INDEX "training_param_loc_locale_idx" ON "training_parameter_localization" USING btree ("localeKey");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "assessment_parameter_localization"
    ADD CONSTRAINT "assessment_parameter_localization_fk_0"
    FOREIGN KEY("parameterId")
    REFERENCES "assessment_parameter"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "asset_localization"
    ADD CONSTRAINT "asset_localization_fk_0"
    FOREIGN KEY("assetId")
    REFERENCES "asset"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "theory_chapter_localization"
    ADD CONSTRAINT "theory_chapter_localization_fk_0"
    FOREIGN KEY("chapterId")
    REFERENCES "theory_chapter"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "training_parameter_localization"
    ADD CONSTRAINT "training_parameter_localization_fk_0"
    FOREIGN KEY("parameterId")
    REFERENCES "training_parameter"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260528093813698', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260528093813698', "timestamp" = now();

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
