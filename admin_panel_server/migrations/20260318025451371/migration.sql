BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "assessment_parameter" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint,
    "paramId" text NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "maxScore" bigint NOT NULL,
    "logic" text NOT NULL,
    "feedbackLow" json NOT NULL,
    "feedbackMedium" json NOT NULL,
    "feedbackHigh" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "module_config" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint,
    "theoryModule" boolean NOT NULL DEFAULT false,
    "aiExpertModule" boolean NOT NULL DEFAULT false,
    "smartTrainingModule" boolean NOT NULL DEFAULT false,
    "assessmentModule" boolean NOT NULL DEFAULT false,
    "defaultLanguage" text NOT NULL DEFAULT 'en'::text,
    "supportedLanguages" json
);

-- Indexes
CREATE UNIQUE INDEX "module_config_organization_idx" ON "module_config" USING btree ("organizationId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "theory_chapter" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint,
    "chapterOrder" bigint NOT NULL,
    "title" text NOT NULL,
    "thumbnailUrl" text,
    "videoUrl" text,
    "videoMetadata" json,
    "questions" json
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "training_parameter" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint,
    "paramId" text NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "maxScore" bigint NOT NULL,
    "logic" text NOT NULL,
    "hint" text,
    "feedbackLow" json NOT NULL,
    "feedbackMedium" json NOT NULL,
    "feedbackHigh" json NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "assessment_parameter"
    ADD CONSTRAINT "assessment_parameter_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "module_config"
    ADD CONSTRAINT "module_config_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "theory_chapter"
    ADD CONSTRAINT "theory_chapter_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "training_parameter"
    ADD CONSTRAINT "training_parameter_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260318025451371', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260318025451371', "timestamp" = now();

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
