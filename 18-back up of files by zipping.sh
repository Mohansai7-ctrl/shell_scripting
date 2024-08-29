#!/bin/bash

#first check and pop up to user that while running the script itself they have to provide dynamically the source dir, destination dir and no of days files are older to delete(this is optional)
# Then to check provided source dir is existing and contains the files or not.
# If yes, will backup the files in destination dir, by zipping it

# then check zipped file exists and it contains the log files or not
# then delete the log files from source directory.

SOURCE_DIR=$1
DESTINATION_DIR=$2
NO_OF_DAYS=${3:-14}

USAGE(){
    echo "Pls provide the details and execute it like <script_name> <source_dir> <destination_dir> <no of days older to be deleted(optional)> "
    exit 1

}

#Checking user provided source and desti dir or not.
if [ $# -lt 2 ]
then
    USAGE
else
    echo "Proceeding further"
fi

#Checking source dir exists or not
if [ ! -d $SOURCE_DIR]
then
    echo "Pls cross check the source dir, as it is not present"
    exit 1
else  
    echo "Source dir is present, hence proceeding further"
fi

#Checking Destination dir exists or not.
if [ ! -d $DESTINATION_DIR]
then
    echo "Pls cross check the Destination dir, as it is not present"
    exit 1
else  
    echo "Destination dir is present, hence proceeding further"
fi

#chekcing source dir has .log files which are older than 14 days

LOG_FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +$NO_OF_DAYS3)

if [ -n $LOG_FILES]
then
    echo "Log files are there"
    $LOG_FILES | zip $DESTINATION_DIR -@
    echo "Zipping in destination folder is completed"
    while IFS= read -r files
    do
        echo "Files are: $files"
        rm -rf $files

    done <<< $LOG_FILES
else 
    echo "Log files are not there which are older than 14 days"
    exit 1
fi 



