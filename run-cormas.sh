#!/usr/bin/env bash
set -e

CONFIG="$1"
MODEL="$2"
shift 2

cd /app

rm -rf /app/pharo-local/iceberg

cp "$CONFIG" /app/config.json
cp "$MODEL" /app/model.cmx

./pharo --headless Pharo.image st /app/run-simulation.st -- "$@"