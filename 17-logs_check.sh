#!/bin/bash

userid=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

CHECK_ROOT(){
    if [ $userid -ne 0 ]
    then
        echo -e "$R You dont have root privileges to run this script, Please run this script with root access $N"
        exit 1
    else
        echo -e "$G Hurray! As you are running this with root access, proceeding further $N"
    fi
}

CHECK_ROOT

LOG_FOLDER=/home/ec2-user/logs
mkdir -p $LOG_FOLDER

if [ -d $LOG_FOLDER ]
then    
    echo "Folder is already exists, hence proceeding further"
else
    echo "Provided folder/directory is not there, Kindly check it further or import it"
fi

LOG_FILE=$(find $LOG_FOLDER -name "*.log" -mtime +14)
echo "This directory consists of these files: $LOG_FILE"


while IFS= read -r files
do
    echo "As these are older than 14 days, deleting these files: $files"
    #rm -rf $files

done <<< $LOG_FILE
