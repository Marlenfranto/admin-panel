BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "training_session_result" (
    "id" bigserial PRIMARY KEY,
    "appUserId" bigint NOT NULL,
    "organizationId" bigint NOT NULL,
    "externalUserId" text NOT NULL,
    "overallPercentage" bigint NOT NULL,
    "criteriaScores" json,
    "completedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "training_session_result_user_org_idx" ON "training_session_result" USING btree ("appUserId", "organizationId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "training_session_result"
    ADD CONSTRAINT "training_session_result_fk_0"
    FOREIGN KEY("appUserId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_session_result"
    ADD CONSTRAINT "training_session_result_fk_1"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260319044441336', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260319044441336', "timestamp" = now();

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
