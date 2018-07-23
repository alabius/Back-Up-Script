#!/bin/bash

#get the current date
BACKUPTIME=`date +"%Y%m%d-%H%M%S"` 
baseDir=~
backupDir='backup'

###### ARGUMENTS #########

#The directory that the user wants to zip up
SOURCE_DIR=$1

#the maximum number of files in the backup directory
MAX_BACKUP_THRESHOLD=$2

#The parent directory of the directory that the user wants to zip up
SOURCE_DIR_PARENT_DIR=$(dirname $SOURCE_DIR)

#The (STANDALONE) name of the folder within the parent directory that the user wants to zip up
SOURCE_DIR_BASENAME=$(basename $SOURCE_DIR)

DESTINATION="$baseDir/$backupDir"

LOG_NAME=""$SOURCE_DIR_BASENAME"_backup_$BACKUPTIME.log"

############################################


if [[ ! -d $DESTINATION ]]; then
    mkdir $DESTINATION
    echo "$backupDir Created" >> $DESTINATION/$LOG_NAME
fi

echo "" >> $DESTINATION/$LOG_NAME 

#FILENAME will be/hold the name of the file AFTER it has been zipped up
FILENAME=""$SOURCE_DIR_BASENAME""_backup_$BACKUPTIME.tar.gz"" >> $DESTINATION/$LOG_NAME

echo "" >> $DESTINATION/$LOG_NAME

echo "Source Folder = $SOURCE_DIR" >> $DESTINATION/$LOG_NAME
echo "Filename = $FILENAME" >> $DESTINATION/$LOG_NAME
echo "Destination Folder = $DESTINATION/$FILENAME" >> $DESTINATION/$LOG_NAME
echo "command to be run is tar -cvf $DESTINATION/FILENAME -C $SOURCE_DIR_PARENT $SOURCE_DIR_BASENAME" >> $DESTINATION/$LOG_NAME
echo "" >> $DESTINATION/$LOG_NAME

~/bash_scripts/backup_cleanup.sh $MAX_BACKUP_THRESHOLD $DESTINATION $SOURCE_DIR_BASENAME

# 	create the backup
tar -cvf $DESTINATION/$FILENAME -C $SOURCE_DIR_PARENT_DIR $SOURCE_DIR_BASENAME 2>> $DESTINATION/$LOG_NAME 
echo ""

echo "Logs for zip operation can be found at $DESTINATION with filename $LOG_NAME"

