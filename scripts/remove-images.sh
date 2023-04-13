#!/usr/bin/env bash
set -e

readarray -t image_ids < <(docker image ls --format='{{print .Id }}' --filter reference=animal-service)
if [[ "${#image_ids[@]}" -gt 0 ]]
then
  docker image rm --force "${image_ids[@]}"
fi