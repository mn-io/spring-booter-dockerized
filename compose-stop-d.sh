#!/usr/bin/env sh
set -ex

cd $(dirname "${0}") # run script its local dir

docker-compose \
  --file compose-profiles/base.yml \
  --file compose-profiles/with-database.yml \
  --file compose-profiles/with-backend.yml \
  --file compose-profiles/with-backend-db-migration.yml \
  --project-name spring-booter \
  down
