BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "manager_notification" ADD COLUMN "teamId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "organization" DROP CONSTRAINT "organization_fk_1";
ALTER TABLE "organization" DROP COLUMN "parentId";
--
-- ACTION ALTER TABLE
--
DROP INDEX "organization_user_unique_idx";
ALTER TABLE "organization_user_link" DROP CONSTRAINT "organization_user_link_fk_1";
ALTER TABLE "organization_user_link" ADD COLUMN "teamId" bigint;
ALTER TABLE "organization_user_link" ALTER COLUMN "organizationId" DROP NOT NULL;
ALTER TABLE "organization_user_link" ALTER COLUMN "appUserId" DROP NOT NULL;
CREATE INDEX "organization_user_unique_idx" ON "organization_user_link" USING btree ("organizationId", "appUserId", "teamId");
--
-- ACTION CREATE TABLE
--
CREATE TABLE "team" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "organizationId" bigint NOT NULL,
    "managerId" bigint,
    "_organizationTeamsOrganizationId" bigint
);

-- Indexes
CREATE UNIQUE INDEX "team_name_org_idx" ON "team" USING btree ("name", "organizationId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_module_progress" ADD COLUMN "teamId" bigint;
ALTER TABLE "user_module_progress" ALTER COLUMN "appUserId" DROP NOT NULL;
ALTER TABLE "user_module_progress" ALTER COLUMN "organizationId" DROP NOT NULL;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "manager_notification"
    ADD CONSTRAINT "manager_notification_fk_0"
    FOREIGN KEY("teamId")
    REFERENCES "team"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "organization_user_link"
    ADD CONSTRAINT "organization_user_link_fk_2"
    FOREIGN KEY("appUserId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "organization_user_link"
    ADD CONSTRAINT "organization_user_link_fk_1"
    FOREIGN KEY("teamId")
    REFERENCES "team"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "team"
    ADD CONSTRAINT "team_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "team"
    ADD CONSTRAINT "team_fk_1"
    FOREIGN KEY("managerId")
    REFERENCES "app_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "team"
    ADD CONSTRAINT "team_fk_2"
    FOREIGN KEY("_organizationTeamsOrganizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_module_progress"
    ADD CONSTRAINT "user_module_progress_fk_2"
    FOREIGN KEY("teamId")
    REFERENCES "team"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260401083831761', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260401083831761', "timestamp" = now();

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
