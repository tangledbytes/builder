#!/bin/bash

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/temp/upgrade/node-14-to-16 https://github.com/utkarsh-pro/noobaa-core.git

# Run tests
cd noobaa-core
make tester || exit 1
docker run --user root --rm --name test1 noobaa-tester ./src/test/unit_tests/run_npm_test_on_test_container.sh -s sudo_index.js || exit 1