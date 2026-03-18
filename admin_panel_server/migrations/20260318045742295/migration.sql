BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "asset" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint,
    "name" text NOT NULL,
    "version" text NOT NULL,
    "url" text NOT NULL,
    "description" text,
    "module" text NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "module_config" ADD COLUMN "aiChatPrompt" text;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "asset"
    ADD CONSTRAINT "asset_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260318045742295', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260318045742295', "timestamp" = now();

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
