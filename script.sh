#!/bin/bash

set -e

# Setup a kind cluster
# kind create cluster

# Enable qemu virtualization in docker
docker run --privileged --rm tonistiigi/binfmt --install all

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/add/rpm-builds https://github.com/utkarsh-pro/noobaa-core.git
cd noobaa-core
mkdir -p build/rpm

# Build RPM for amd64 and ppc64le
make rpm PLATFORM=amd64 BUILD_S3SELECT=BUILD_S3SELECT=0
make rpm PLATFORM=ppc64le BUILD_S3SELECT=BUILD_S3SELECT=0

# Upload the assets
sudo mv build $GITHUB_WORKSPACE/artifacts/build

# Build the tester
# make tester

# Upload the tester image to the kind cluster
# kind load docker-image noobaa-tester
# kind load docker-image noobaa

# Run the ceph test
# cd ./src/test/framework/ && ./run_test_job.sh --name s3-tests --image noobaa --tester_image noobaa-tester --tests_list ./system_tests_list.js --job_yaml ../../../.travis/travis_test_job.yaml --wait