#!/bin/bash

set -e

export GOROOT=`go env GOROOT`
export GOPATH=`go env GOPATH`

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/feature/loadbalancer-cidr-control https://github.com/utkarsh-pro/noobaa-operator.git

cd noobaa-operator

# Build the assets
make gen && make gen-api && make

# Convert docker images to a tar file
docker save noobaa/noobaa-operator:5.12.0 > noobaa-operator.tar
docker save noobaa/noobaa-operator-catalog:5.12.0 > noobaa-operator-catalog.tar

# Upload the assets
mv noobaa-operator.tar $GITHUB_WORKSPACE/artifacts/noobaa-operator.tar
mv noobaa-operator-catalog.tar $GITHUB_WORKSPACE/artifacts/noobaa-operator-catalog.tar
mv build $GITHUB_WORKSPACE/artifacts/build