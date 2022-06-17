#!/bin/bash

set -e

export GOROOT=`go env GOROOT`
export GOPATH=`go env GOPATH`

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/feature/loadbalancer-cidr-control https://github.com/utkarsh-pro/noobaa-operator.git

cd noobaa-operator

# Build the assets
make gen && make gen-api && make

# Push the docker image to ttl.sh
export IMAGE_NAME=$(uuidgen)
docker tag noobaa/noobaa-operator:5.12.0 ttl.sh/$IMAGE_NAME:2h
docker push ttl.sh/$IMAGE_NAME:2h

export IMAGE_NAME=$(uuidgen)
docker tag noobaa/noobaa-operator-catalog:5.12.0 ttl.sh/$IMAGE_NAME:2h
docker push ttl.sh/$IMAGE_NAME:2h

# Upload the assets
mv build $GITHUB_WORKSPACE/artifacts/build