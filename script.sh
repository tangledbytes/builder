#!/bin/bash

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/temp/fix/anon-user-actions https://github.com/utkarsh-pro/noobaa-core.git

# Run tests
cd noobaa-core

# Git Commit
COMMIT=$(git log --format="%H" -n 1)

# Check if image already exists on docker hub
if docker pull ttl.sh/noobaa-tester:$COMMIT; then
	echo "Image already exists"
	docker tag ttl.sh/noobaa-tester:$COMMIT noobaa-tester
else
	make tester
	docker tag noobaa-tester ttl.sh/noobaa-tester:$COMMIT
	docker push ttl.sh/noobaa-tester:$COMMIT
fi

make test