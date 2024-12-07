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

#!/bin/bash

# Threshold for disk usage (in percentage)
THRESHOLD=80

# Email configurations
TO_EMAIL="admin@example.com"
SUBJECT="Disk Usage Alert"

# Get disk usage information
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $6 }' | while read -r output; do
    # Extract the usage percentage and mount point
    USAGE=$(echo "$output" | awk '{ print $1 }' | sed 's/%//')
    MOUNT_POINT=$(echo "$output" | awk '{ print $2 }')
    
    # Check if usage exceeds threshold
    if [ "$USAGE" -ge "$THRESHOLD" ]; then
        MESSAGE="Warning: Disk usage on $MOUNT_POINT has reached ${USAGE}%."
        
        # Send email alert
        echo "$MESSAGE" | mail -s "$SUBJECT" "$TO_EMAIL"
    fi
done












# while IFS= read -r line
# do
# used=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
# mountedon=$(echo $line | awk -F " " '{print $NF}')
# if [ $used -gt $Threshold ]
# echo "Filesystems which has used more than $Threshold % which are mounted on $mountedon "
# fi
# done <<< $DISK_USAGE