#!/bin/bash

# This script will give you which paths having using disk usage more than 75%
# showing them
# as it exceed 75%, need to show to user to decide on next actions



DISK_USAGE=$(df -hT | grep xfs)
Threshold=5 #Here we took threshold as 5, but in real time projects defualt threshold value is 75% means we should check the filesystems which has exceed the disk usage of 75%


G="\e[32m"
N="\e[0m"

while IFS= read -r line
do
usage=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1) #Now it checks line by line
Partition=$(echo $line | awk -F " " '{print $NF}')
filesystems=$(echo $line | cut -d " " -f1)

if [ $usage -gt $Threshold ]
then
    echo -e "$G The file systems $filesystems which are consuming more disk usage are: $usage and those are mounted on $Partition $N "
fi


done <<< $DISK_USAGE











# while IFS= read -r line
# do
# used=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
# mountedon=$(echo $line | awk -F " " '{print $NF}')
# if [ $used -gt $Threshold ]
# echo "Filesystems which has used more than $Threshold % which are mounted on $mountedon "
# fi
# done <<< $DISK_USAGE