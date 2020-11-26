#!/usr/bin/env sh
set -ex

# NB: this is a convenience script to give a living example
# how to build this project within docker.

# This does not start any dependencies like database service.
# Please refer to compose-start-d.sh

docker build . --tag spring-booter-backend:latest
