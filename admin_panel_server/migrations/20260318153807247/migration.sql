BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "manager_notification" (
    "id" bigserial PRIMARY KEY,
    "managerId" bigint NOT NULL,
    "overdueUserId" bigint NOT NULL,
    "organizationId" bigint NOT NULL,
    "moduleId" text NOT NULL,
    "isRead" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "manager_notification_unique_idx" ON "manager_notification" USING btree ("managerId", "overdueUserId", "moduleId");


--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260318153807247', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260318153807247', "timestamp" = now();

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
