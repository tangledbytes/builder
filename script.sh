#!/bin/bash

set -e

function registry() {
	local IMAGE_NAME=$(uuidgen)
	local REF=ttl.sh/$IMAGE_NAME:2d

	echo $REF
}

function docker_push() {
	local REF=`registry`
	docker tag $1 $REF
	docker push $REF

	echo "[PUSHED] $1 => $REF"
}

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/fix/anon-user-actions https://github.com/utkarsh-pro/noobaa-core.git

cd noobaa-core

# Build the assets
make noobaa

# Push the docker image to ttl.sh
docker_push noobaa

# Upload the assets
# mv build $GITHUB_WORKSPACE/artifacts/build
# FORCE4
