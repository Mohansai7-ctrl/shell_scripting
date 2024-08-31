#!/bin/bash

#Checking the logs directory non empty or not
# then checking is it contains the files which are older than 14
# if yes then deleting those files by reading each file
LOGS="/home/ec2-user/logs_backup"
mkdir -p $LOGS
OLDER_FILES=$(find ${LOGS} -name "*.log" -mtime +14)

echo "$OLDER_FILES"


if [ -d $LOGS ]
then
    echo "Directory exists"
else
    echo "doesn't exist"
fi

if [[ -n $OLDER_FILES ]]
then
    echo "Found the files which are older than 14 days"
    while IFS= read -r file
    do
    echo "14 days older files are: $OLDER_FILES"
    echo "Hence Deleting them"
    rm -rf $file
    done <<< $OLDER_FILES
else
    echo "No 14 days older files are found"
fi

        
    


