#!/usr/bin/env bash
# Run one simulation of a zipped Cormas model: run.sh <model zip> <arguments of simulation.st>
set -e

MODEL="$1"
shift

cd /app
./pharo --headless Pharo.image st /app/simulation.st -- \
  model="$MODEL" \
  workspace="$(mktemp -d)/workspace" \
  results=/app/results.json \
  "$@"
