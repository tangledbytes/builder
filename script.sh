#!/bin/bash

set -e

export GOROOT=`go env GOROOT`
export GOPATH=`go env GOPATH`

function registry() {
	local IMAGE_NAME=$(uuidgen)
	local REF=ttl.sh/$IMAGE_NAME:2h

	echo $REF
}

function docker_push() {
	local REF=`registry`
	docker tag $1 $REF
	docker push $REF

	echo "Pushed $REF"
}

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/temp/cleanup/allowed-buckets https://github.com/utkarsh-pro/noobaa-operator.git

cd noobaa-operator

# Build the assets
make gen && make gen-api && make

# Push the docker image to ttl.sh
docker_push noobaa/noobaa-operator:5.12.0
docker_push noobaa/noobaa-operator-catalog:5.12.0

# Upload the assets
# mv build $GITHUB_WORKSPACE/artifacts/build