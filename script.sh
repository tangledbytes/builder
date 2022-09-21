#!/bin/bash

# Clone the noobaa repository
git clone --depth=1 -b utkarsh-pro/temp/fix/anon-user-actions https://github.com/utkarsh-pro/noobaa-core.git

# Run tests
cd noobaa-core
make test