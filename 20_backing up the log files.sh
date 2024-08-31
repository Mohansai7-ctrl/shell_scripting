#!/bin/bash

SOURCE_DIR=$1
DESTINATION_DIR=$2
DAYS=${3:-14}

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
ZIP_FILE="$DESTINATION_DIR-$TIMESTAMP.zip"

CHECKS(){
    echo "Directory exists"
}

INPUTS(){
    if [[ $# -lt 2 ]]
    then
        echo " You have to provide minimum two arguments in this format: <sh 20_backing up the log files.sh> <Source directory path> <Destination directory path> <files which are older than no of days(optional)>"
        exit 1
    else
        echo "As you provided both the directories paths, we are proceeding further"
    fi
}

#INPUTS

if [ -d $SOURCE_DIR ]
then
    CHECKS
else
    echo "Source dir doesn't exists"
fi

if [ -d $DESTINATION_DIR ]
then
    CHECKS
else
    echo "Destination dir doesn't exists"
fi

LOG_FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)

if [ ! -z $LOG_FILES ]
then
    echo "Yes, this directory consists of older files which are more than $DAYS"
    $LOG_FILES | zip "$ZIP_FILE" -@
    if [ -f $ZIP_FILE ]
    then
        echo "As zip file exists, going to delete older files from source directory"
        while IFS= read -r file
        do
        echo "As zipping to destination folder done, now deleting these older files from source directory"
        rm -rf $file
        done <<< $LOG_FILES
    else
        echo "Some issue with zipping the file, need to check it"
    fi

else
    echo "No files found which are older than 14 days"
fi



