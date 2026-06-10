#!/usr/bin/env bash
set -e

MODEL="$1"
shift

cd /app

rm -rf /app/pharo-local/iceberg
cp "$MODEL" /app/model.cmx

./pharo --headless Pharo.image st /app/simulation.st -- "$@"