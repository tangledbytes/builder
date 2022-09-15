#!/bin/bash

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/temp/upgrade/node-14-to-16 https://github.com/utkarsh-pro/noobaa-core.git

# Run tests
cd noobaa-core
make test