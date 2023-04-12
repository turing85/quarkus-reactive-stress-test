#!/usr/bin/env bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )" 1> /dev/null
cd lua-scripts
wrk \
  --threads "${1:-1}" \
  --connections "${2:-4}" \
  --duration "${3:-30s}" \
  --rate "${4:-10k}" \
  --latency \
  --script create_animals.lua \
  http://localhost:8080
