#!/bin/bash

set -e

# Setup a kind cluster
kind create cluster

# Clone the noobaa repository
git clone --depth=1 https://github.com/utkarsh-pro/noobaa-core.git

cd noobaa-core

# Build the tester
make tester

# Upload the tester image to the kind cluster
kind load docker-image noobaa-tester
kind load docker-image noobaa

# Run the ceph test
cd ./src/test/framework/ && ./run_test_job.sh --name s3-tests --image noobaa --tester_image noobaa-tester --tests_list ./system_tests_list.js --job_yaml ../../../.travis/travis_test_job.yaml --wait