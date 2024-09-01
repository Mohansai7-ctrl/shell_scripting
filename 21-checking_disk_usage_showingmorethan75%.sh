#!/bin/bash

# This script will give you which paths having using disk usage more than 75%
# showing them
# as it exceed 75%, need to show to user to decide on next actions



# DISK_USAGE=$(df -hT | grep xfs)
# Threshold=5

# G="\e[32m"
# N="\e[0m"

# while IFS= read -r line
# do
# usage=$($line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
# Partition=$($line | grep xfs | awk -F " " '{print $NF}')

# if [[ $usage -ge $Threshold ]]
# then
#     echo -e "$G The file systems which are consuming more disk usage are: $usage and those are mounted on $Partition $N "
# fi


# done <<< $DISK_USAGE






DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5 #real projects, it is usually 75


while IFS= read -r line #IFS,internal field seperatpor, empty it will ignore while space.-r is for not to ingore special charecters like /
do
    USAGE=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | grep xfs | awk -F " " '{print $NF}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        echo "$PARTITION is more than $DISK_THRESHOLD, current value: $USAGE. Please check"
    fi
done <<< $DISK_USAGE
