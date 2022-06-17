#/bin/bash

echo "I will just sleep for a while..."
sleep 60
echo "This is a message that was generated in the Github Action after sleeping for a while" > $GITHUB_WORKSPACE/artifacts/message
