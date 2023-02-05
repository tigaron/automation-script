#!/usr/bin/env bash

# create directory to install Compose for the active user under $HOME directory
DOCKER_CONFIG=${DOCKER_CONFIG:-${HOME}/.docker}
mkdir -p ${DOCKER_CONFIG}/cli-plugins

# downloads the latest release of Docker Compose from the Compose releases repository
DOWNLOAD_URL=$(curl -fsSL https://api.github.com/repos/docker/compose/releases/latest | grep "tag_name" | awk '{print "https://github.com/docker/compose/releases/download/" substr($2, 2, length($2)-3) "/docker-compose-linux-x86_64"}')
curl -fsSL ${DOWNLOAD_URL} -o ~/.docker/cli-plugins/docker-compose

# set the correct permissions so that the docker compose command is executable
chmod +x ${HOME}/.docker/cli-plugins/docker-compose
