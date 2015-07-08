#!/bin/bash
#This script checks all mounts and will send an email alert if you reach a certain threshold
#You can add this as a cronjob to monitor all mountpoints
#mackyruiz
#
ADMIN="your@email.com"


df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $5 " " $1 }' | while read output;
do
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge 85 ]; then
    echo "Running out of space \"$partition ($usep%)\" as on $(date)" > /tmp/email.txt
     mail -s "Alert: $partition Almost out of disk space" $ADMIN < /tmp/email.txt ;
  fi
done
