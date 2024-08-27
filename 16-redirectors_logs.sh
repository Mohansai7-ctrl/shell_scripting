#!/bin/bash

userid=(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"


LOGS_FOLDER="/var/log/shell-script"
mkdir -p $LOGS_FOLDER
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"



#checking CHECK Function whether having root access or not
CHECK(){
    if [ $userid -ne 0 ]
    then
        echo -e "$R You don't have root access, Please switch to root to proceed further $N" | tee -a $LOG_FILE
    else
        echo -e "$G Hurray! You have root access, Pls proceed further $N" | tee -a $LOG_FILE
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R FAILED $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$G SUCCESS $N" | tee -a $LOG_FILE

}

USAGE(){
    echo -e "$Y you have to give the packages in arguments,pls give as filename.sh package1 package2 .... $N" | tee -a $LOG_FILE
    exit 1

}


CHECK

if [ $# -eq 0 ]
then
    USAGE
fi

for package in $@

do
dnf list installed $package &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo -e "$R Your given $package is not installed, now its going to be installed $N" | tee -a $LOG_FILE
    dnf install $package -y | tee -a $LOG_FILE
    VALIDATE $? "Your installation $package is:"
else
    echo -e "$G Your $package is already installed, nothing to do! $N" | tee -a $LOG_FILE
fi

done