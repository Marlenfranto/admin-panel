BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "training_session_result_user_org_idx";
ALTER TABLE "training_session_result" DROP CONSTRAINT "training_session_result_fk_0";
ALTER TABLE "training_session_result" ALTER COLUMN "appUserId" DROP NOT NULL;
CREATE INDEX "training_session_result_org_idx" ON "training_session_result" USING btree ("organizationId");
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "training_session_result"
    ADD CONSTRAINT "training_session_result_fk_0"
    FOREIGN KEY("appUserId")
    REFERENCES "app_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR admin_panel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('admin_panel', '20260319051516300', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260319051516300', "timestamp" = now();

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
