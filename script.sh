#/bin/bash

echo "Cloning NooBaa Operator..."
git clone --depth=1 https://github.com/noobaa/noobaa-operator.git

echo "Build NooBaa Operator..."
make gen && make gen-api && make

echo "Dump docker image as tar file..."
docker save noobaa/noobaa-operator:5.12.0 -o noobaa-operator.tar

echo "Uploading tar file to GitHub..."
mv noobaa-operator.tar $GITHUB_WORKSPACE/artifacts/noobaa-operator.tar
