#!/bin/sh

HOSTNAME=`hostname`
START=`date`
echo "Starting backup of ${HOSTNAME}"


rsync -avh --exclude  "/share/" --exclude "/mnt/" --exclude "/proc/" --exclude "/media/" --exclude "/sys" --exclude "/dev" / /media/43c1174c-83d4-4238-a51e-9ee6a517c228/backup/${HOSTNAME}

END=`date`

echo "Backup started at ${START} and ended at ${END} for ${HOSTNAME}">>/media/43c1174c-83d4-4238-a51e-9ee6a517c228/backup/${HOSTNAME}.log

