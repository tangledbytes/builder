#/bin/bash

JOB_ID=`gh run list -L 1 -w build --json databaseId -t '{{ (index . 0).databaseId | printf "%.f" }}'`
gh run download $JOB_ID 