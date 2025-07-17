BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "recipe" ADD COLUMN "deletedAt" timestamp without time zone;

--
-- MIGRATION VERSION FOR i_pod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('i_pod', '20250715195150371', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250715195150371', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
