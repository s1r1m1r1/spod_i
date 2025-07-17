# i_pod_server

To run your server, you first need to start Postgres and Redis. It's easiest to do with Docker.
run without vpn 
<!-- commands server-->
docker compose up --build --detach
serverpod generate
serverpod create-migration
dart run bin/main.dart --apply-migrations 

docker compose stop

