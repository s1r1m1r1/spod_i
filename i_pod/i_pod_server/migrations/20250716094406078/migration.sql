BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "recipe" ADD COLUMN "userId" bigint;

--
-- MIGRATION VERSION FOR i_pod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('i_pod', '20250716094406078', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250716094406078', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
