#!/usr/bin/env bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )" 1> /dev/null
cd ..

flavour="${1:-temurin}"

scripts/undeploy.sh
docker-compose \
  --file local-deployment/docker-compose.yml \
  up \
  --detach \
  postgres pgadmin4
./mvnw flyway:migrate
docker-compose \
  --file local-deployment/docker-compose.yml \
  --profile "${flavour}" \
  up \
  --detach \
  --build