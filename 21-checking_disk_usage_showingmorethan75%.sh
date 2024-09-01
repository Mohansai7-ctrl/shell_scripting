#!/bin/bash

# This script will give you which paths having using disk usage more than 75%
# showing them
# as it exceed 75%, need to show to user to decide on next actions



DISK_USAGE=$(df -hT | grep xfs)
Threshold=5

G="\e[32m"
N="\e[0m"

while IFS= read -r line
do
usage=$($line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -F1)
Partition=$($line | grep xfs | awk -F " " '{print $NF}')

if [[ $usage -ge $Threshold ]]
then
    echo -e "$G The file systems which are consuming more disk usage are: $usage and those are mounted on $Partition $N "
fi


done <<< $DISK_USAGE