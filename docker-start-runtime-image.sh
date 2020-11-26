#!/usr/bin/env sh
set -ex

# NB: this is a convenience script to give a living example
# how to build this project within docker.

# This does not start any dependencies like database service.
# Please refer to compose-start-d.sh

# https://docs.docker.com/engine/reference/commandline/run/
docker run \
  -p 8080:8080 \
  --name spring-booter-backend-service \
  --rm \
  spring-booter-backend:latest \
  mvn spring-boot:run
