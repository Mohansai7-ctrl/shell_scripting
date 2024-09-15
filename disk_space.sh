#!/bin/bash
userid=$(id -u)

CHECK(){
    echo -e "$R you dont have root privileges, plese login or use root access $N "
    exit 1
}

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

mkdir -p /var/logs/expense
LOGS_FOLDER="/var/logs/expense"
SCRIPT_NAME="(echo $0 | awk -F "." '{print 1F}')"
TIMESTAMP=$(date +%Y-%h-%m-%H-%M-%S)
LOG_FILE=($LOGS_FOLDER/$SCRIPT_NAME/$TIMESTAMP-app.log)
THRESHOLD=5

DISK_FILES=$(df -hT | grep xfs)

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "your $2 is failed"

    else
        echo "your $2 is SUCCESS"

    fi

}


if [ ${userid} -ne 0 ]
then
    CHECK
else
    echo -e "$R You have root access, you can proceed further $N"  | tee -a $LOG_FILE

fi



while IFS=read -r line
do
DISK_PERCENTAGE=$(echo $line | awk -F " " '{print $6F}')
DISK_FILE=$(echo $line | awk -F " " '{print $NF }')

if [ $DISK_PERCENTAGE -gt $THRESHOLD ]
then    
 echo -e "$Y need to check these xfs files as having more than threshold $DISK_FILE $N"
 echo "files are $file "

else  
    echo -e "$B no files are greater than threshold, hence safe $N"
fi 

done <<< $DISK_FILES &>> $LOG_FILE




