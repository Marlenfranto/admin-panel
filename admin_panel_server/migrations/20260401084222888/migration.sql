BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "team" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "manager_notification" DROP COLUMN "teamId";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "organization" ADD COLUMN "parentId" bigint;
--
-- ACTION ALTER TABLE
--
DROP INDEX "organization_user_unique_idx";
ALTER TABLE "organization_user_link" DROP CONSTRAINT IF EXISTS "organization_user_link_fk_2";
ALTER TABLE "organization_user_link" DROP CONSTRAINT IF EXISTS "organization_user_link_fk_1";
ALTER TABLE "organization_user_link" DROP COLUMN "teamId";
ALTER TABLE "organization_user_link" ALTER COLUMN "organizationId" SET NOT NULL;
ALTER TABLE "organization_user_link" ALTER COLUMN "appUserId" SET NOT NULL;
CREATE UNIQUE INDEX "organization_user_unique_idx" ON "organization_user_link" USING btree ("organizationId", "appUserId");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_module_progress" DROP COLUMN "teamId";
ALTER TABLE "user_module_progress" ALTER COLUMN "appUserId" SET NOT NULL;
ALTER TABLE "user_module_progress" ALTER COLUMN "organizationId" SET NOT NULL;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "organization"
    ADD CONSTRAINT "organization_fk_1"
    FOREIGN KEY("parentId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "organization_user_link"
    ADD CONSTRAINT "organization_user_link_fk_1"
    FOREIGN KEY("appUserId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260401084222888', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260401084222888', "timestamp" = now();

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
