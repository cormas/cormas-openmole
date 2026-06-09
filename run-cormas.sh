#!/usr/bin/env bash
set -e

CONFIG="$1"
shift

cd /app

rm -rf /app/pharo-local/iceberg
cp "$CONFIG" /app/config.json

./pharo --headless Pharo.image st /app/install-model.st
./pharo --headless Pharo.image st /app/run-simulation.st -- "$@"