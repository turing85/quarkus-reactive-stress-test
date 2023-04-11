#!/usr/bin/env bash
set -e

wrk \
  --threads "${1:-2}" \
  --connections "${2:-4}" \
  --duration "${3:-30s}" \
  --script create_animals.lua \
  http://localhost:8080