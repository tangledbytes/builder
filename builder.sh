#/bin/bash
set -e
set -o pipefail

REPO=utkarsh-pro/builder
NEW_SCRIPT=${1:-script.sh}
WD=$(pwd)

# Clone the builder repo
git clone https://github.com/$REPO.git ${TMPDIR}builder

# Move the new script to the builder repo
mv $NEW_SCRIPT ${TMPDIR}builder/script.sh

# Add and commit the new script
cd ${TMPDIR}builder
git add script.sh
git commit -m "Update script"

# Push the changes to the repo
git push origin master

# Get back to the previous working directory
cd $WD

# Remove the builder repo
rm -rf ${TMPDIR}builder

# Download the artifacts produced
RUN_ID=`gh run list -L 1 -w build --json databaseId -t '{{ (index . 0).databaseId | printf "%.f" }}' -R $REPO`

gh run view -i 1 -R $REPO $RUN_ID --log --exit-status
gh run download $RUN_ID -R $REPO