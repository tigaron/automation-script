#!/usr/bin/env bash

# remove any previous Go installation
sudo rm -rf /usr/local/go

# downloads the latest release of Golang
LATEST_VERSION=$(curl -fsSL https://golang.org/VERSION?m=text)
curl -fsSL https://go.dev/dl/${LATEST_VERSION}.linux-amd64.tar.gz -o ${HOME}/${LATEST_VERSION}.linux-amd64.tar.gz

# extract the archive you just downloaded
sudo tar -C /usr/local -xzf ${HOME}/${LATEST_VERSION}.linux-amd64.tar.gz

# add /usr/local/go/bin to the PATH environment variable
grep -Fxq "export PATH=\$PATH:/usr/local/go/bin" ${HOME}/.profile || echo -e "\nexport PATH=\$PATH:/usr/local/go/bin" >> ${HOME}/.profile
source ${HOME}/.profile

# add GOPATH environment variable
grep -Fxq "export GOPATH=\$HOME/go" ${HOME}/.bashrc || echo -e "\nexport GOPATH=\$HOME/go" >> ${HOME}/.bashrc
grep -Fxq "PATH=\$PATH:\$GOPATH/bin" ${HOME}/.bashrc || echo -e "\nPATH=\$PATH:\$GOPATH/bin" >> ${HOME}/.bashrc
source ${HOME}/.bashrc
