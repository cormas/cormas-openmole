FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    curl unzip git libfreetype6 libfontconfig1 libssl3 libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN curl https://get.pharo.org/130+vmLatest | bash

COPY install-cormas.st /app/install-cormas.st
COPY install-model.st /app/install-model.st
COPY run-simulation.st /app/run-simulation.st

RUN ./pharo --headless Pharo.image st /app/install-cormas.st

CMD ["bash", "-c", "./pharo --headless Pharo.image st /app/install-model.st -- /work/config.json && ./pharo --headless Pharo.image st /app/run-simulation.st -- /work/config.json"]