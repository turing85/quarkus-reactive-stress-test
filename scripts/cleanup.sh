#!/usr/bin/env bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )" 1> /dev/null
cd ..

scripts/undeploy.sh
./mvnw clean

remove_images="${1:-false}"
if [[ "${remove_images}" == true ]]
then
  scripts/remove-images.sh
fi