#!/usr/bin/env bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )" 1> /dev/null
cd ..

flavour="${1:-temurin}"

mvn_args=()
if [[ "${flavour}" == "native" ]]
then
  container_runtime="${2:-docker}"
  mvn_args=("--define native --define quarkus.native.container-runtime=${container_runtime}")
fi

./mvnw "${mvn_args[@]}" clean package