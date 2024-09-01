#!/bin/bash

SOURCE_DIR=$1
DESTINATION_DIR=$2
DAYS=${3:-14} #Here user can provide $3 as optional, if user didnt provide this then 14 can be taken as default days

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
ZIP_FILE="$DESTINATION_DIR/logs_backup-$TIMESTAMP.zip"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"


CHECKS(){
    echo "Directory exists"
}

INPUTS(){
    echo -e "$R You have to provide minimum two arguments in this format: <sh 20_backing up the log files.sh> <Source directory path> <Destination directory path> <files which are older than no of days(optional)> $N "
        
    
}

if [ $# -lt 2 ]
then
    INPUTS
else
    echo -e "$G As provided required arguments, hence proceeding further $N "
fi


if [ -d $SOURCE_DIR ]
then
    CHECKS
else
    echo -e "$G Source dir doesn't exists $N "
fi

if [ -d $DESTINATION_DIR ]
then
    CHECKS
else
    echo -e "$G Destination dir doesn't exists $N "
fi

LOG_FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)

if [ ! -z "$LOG_FILES" ]
then
    echo -e "$G Yes, this directory consists of older files which are more than $DAYS $N"
    find ${SOURCE_DIR} -name "*.log" -mtime +14 | zip "$ZIP_FILE" -@
    if [ -f $ZIP_FILE ]
    then
        echo -e "$Y As zip file exists, going to delete older files from source directory $N"
        sudo chmod +x *.log
        while IFS= read -r file
        do
        echo "As zipping to destination folder done, now deleting these older files from source directory"
        rm -rf $file
        done <<< $LOG_FILES
    else
        echo -e "$R Some issue with zipping the file, need to check it $N"
    fi

else
    echo "No files found which are older than 14 days"
fi

# SOURCE_DIR=$1
# DEST_DIR=$2
# DAYS=${3:-14} #if $3 is empty, default is 14 days.
# TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

# USAGE(){
#     echo -e "$R USAGE:: $N sh 19-backup.sh <source> <destination> <days(optional)>"
# }
# #check the source and destination are provided

# if [ $# -lt 2 ]
# then
#     USAGE
#     exit 1
# else
#     echo "Provided required arguments, hence proceeding further"
# fi



