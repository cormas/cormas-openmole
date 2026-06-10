FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    libfreetype6 \
    libfontconfig1 \
    libssl3 \
    libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Pharo
RUN curl https://get.pharo.org/130+vmLatest | bash

# Work around Iceberg / git ownership issues
RUN printf "[safe]\n\tdirectory = *\n" > /etc/gitconfig

# Install scripts
COPY install-cormas.st /app/install-cormas.st
COPY simulation.st /app/simulation.st
COPY run.sh /app/run.sh

RUN chmod +x /app/run.sh

# Install Cormas once when building the image
RUN ./pharo --headless Pharo.image st /app/install-cormas.st

# OpenMOLE often runs as uid 1000
RUN chown -R 1000:1000 /app

# Default working directory for mounted files
WORKDIR /work

CMD ["/bin/bash"]