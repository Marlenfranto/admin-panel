BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "assessment_parameter" CASCADE;

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
    "scoringRules" json NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "training_parameter" CASCADE;

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
    "scoringRules" json NOT NULL
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
    VALUES ('admin_panel', '20260327114201106', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260327114201106', "timestamp" = now();

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
