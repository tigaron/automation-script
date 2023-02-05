#!/usr/bin/env bash

# downloads the latest release of Golang Migrate from the releases repository
DOWNLOAD_URL=$(curl -fsSL https://api.github.com/repos/golang-migrate/migrate/releases/latest | grep "tag_name" | awk '{print "https://github.com/golang-migrate/migrate/releases/download/" substr($2, 2, length($2)-3) "/migrate.linux-amd64.tar.gz"}')
curl -fsSL ${DOWNLOAD_URL} | tar xz migrate

# move it to system path
mv migrate ${GOPATH}/bin/migrate
