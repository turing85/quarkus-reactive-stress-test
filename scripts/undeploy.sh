#!/usr/bin/env bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )" 1> /dev/null
cd ..

docker-compose \
  --file local-deployment/docker-compose.yml \
  --profile develop \
  --profile distroless \
  --profile native \
  --profile temurin \
  --profile ubi \
  down
