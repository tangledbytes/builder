#!/bin/bash

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/temp/fix/anon-user-actions https://github.com/utkarsh-pro/noobaa-core.git

# Run tests
cd noobaa-core

# Git Commit
COMMIT=$(git log --format="%H" -n 1)
IMAGE_NAME="noobaa-tester"
REMOTE_IMAGE="ttl.sh/noobaa-tester-$COMMIT:2d"

# Check if image already exists on docker hub
if docker pull $REMOTE_IMAGE; then
	echo "Image already exists"
	docker tag $REMOTE_IMAGE noobaa-tester
else
	make tester
	docker tag noobaa-tester $REMOTE_IMAGE 
	docker push $REMOTE_IMAGE 
fi

make test-postgres
