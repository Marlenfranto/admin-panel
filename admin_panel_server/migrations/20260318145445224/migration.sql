BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_module_progress" (
    "id" bigserial PRIMARY KEY,
    "appUserId" bigint NOT NULL,
    "organizationId" bigint NOT NULL,
    "moduleId" text NOT NULL,
    "isEnabled" boolean NOT NULL DEFAULT true,
    "deadline" timestamp without time zone,
    "status" text NOT NULL DEFAULT 'notStarted'::text,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "user_module_progress_unique_idx" ON "user_module_progress" USING btree ("appUserId", "moduleId", "organizationId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_module_progress"
    ADD CONSTRAINT "user_module_progress_fk_0"
    FOREIGN KEY("appUserId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_module_progress"
    ADD CONSTRAINT "user_module_progress_fk_1"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260318145445224', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260318145445224', "timestamp" = now();

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
