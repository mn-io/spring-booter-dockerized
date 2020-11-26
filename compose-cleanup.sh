#!/usr/bin/env sh
set -ex

cd $(dirname "${0}") # run script its local dir

# https://docs.docker.com/compose/reference/rm/
# removes anonymous volumes
# used before 'down' to stop containers with force
docker-compose \
  --file compose-profiles/base.yml \
  --file compose-profiles/with-database.yml \
  --file compose-profiles/with-backend.yml \
  --project-name spring-booter \
  rm --stop --force -v

# https://docs.docker.com/compose/reference/down
# removes anonymous and named volumes,
# networks and volumes defined as external are never removed.
docker-compose \
  --file compose-profiles/base.yml \
  --file compose-profiles/with-database.yml \
  --file compose-profiles/with-backend.yml \
  --project-name spring-booter \
  down --rmi 'local' --volumes
