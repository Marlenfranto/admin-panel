BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "locale_config" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint,
    "regionCode" text NOT NULL,
    "languageCode" text NOT NULL,
    "localeKey" text NOT NULL,
    "displayName" text NOT NULL,
    "enabled" boolean NOT NULL DEFAULT true,
    "isDefault" boolean NOT NULL DEFAULT false,
    "fallbackLocaleKey" text
);

-- Indexes
CREATE UNIQUE INDEX "locale_config_org_key_idx" ON "locale_config" USING btree ("organizationId", "localeKey");
CREATE INDEX "locale_config_org_idx" ON "locale_config" USING btree ("organizationId");
CREATE INDEX "locale_config_key_idx" ON "locale_config" USING btree ("localeKey");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "module_config" ADD COLUMN "defaultLocaleKey" text NOT NULL DEFAULT 'US-en'::text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "region" (
    "id" bigserial PRIMARY KEY,
    "organizationId" bigint,
    "code" text NOT NULL,
    "displayName" text NOT NULL,
    "enabled" boolean NOT NULL DEFAULT true
);

-- Indexes
CREATE UNIQUE INDEX "region_org_code_idx" ON "region" USING btree ("organizationId", "code");
CREATE INDEX "region_org_idx" ON "region" USING btree ("organizationId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "locale_config"
    ADD CONSTRAINT "locale_config_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "region"
    ADD CONSTRAINT "region_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260528091527599', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260528091527599', "timestamp" = now();

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
