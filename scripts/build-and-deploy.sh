#!/usr/bin/env bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )" 1> /dev/null
cd ..

scripts/build.sh "${@}"
scripts/deploy.sh "${@}"