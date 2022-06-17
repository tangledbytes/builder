#/bin/bash
set -e
set -o pipefail

REPO=utkarsh-pro/builder
NEW_SCRIPT=${1:-script.sh}
WD=$(pwd)
BUILD_DIR=${TMPDIR}builder

# Clone the builder repo if it doesn't exist
if [ ! -d $BUILD_DIR ]; then
	echo "Cloning $REPO into $BUILD_DIR..."
	git clone git@github.com:$REPO.git $BUILD_DIR
fi

# Move into the builder repo
cd $BUILD_DIR

# Pull the latest changes
echo "Pulling latest changes..."
git pull

# Move the script to the builder
cd $WD
cp $NEW_SCRIPT $BUILD_DIR/script.sh
cd $BUILD_DIR

# Check if there is anything to be commited
if [ -n "$(git status --porcelain)" ]; then
	echo "Change detected in the script. Committing..."
	git add .
	git commit -m "Update script"
	git push
fi

# Get back to the previous working directory
cd $WD

# Sleep for a while to let the job pick up by the runner
echo "Sleeping for a while to let the job pick up by the runner..."
sleep 15

# Download the artifacts produced
RUN_ID=`gh run list -L 1 -w build --json databaseId -t '{{ (index . 0).databaseId | printf "%.f" }}' -R $REPO`
gh run watch -R $REPO $RUN_ID --exit-status
gh run view -R $REPO $RUN_ID --log --exit-status
gh run download $RUN_ID -R $REPO