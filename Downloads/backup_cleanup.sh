#!/bin/bash

#list out the .gz files that start with the same name as the basename file (in order of modification date) ls -ltr
#check the number of files, if it is equal to 3 or more, delete the oldest file (first from the top).

FILE_THRESHOLD=$1
BACKUP_DIR=$2
BASENAME=$3
BACKUP_FILES_COUNT=$(ls -ltr $BACKUP_DIR/$BASENAME*.gz | wc -l | xargs)
LIST_OF_FILES=$(ls -1 $BACKUP_DIR/$BASENAME*.gz)
OLDEST_FILE_PATH=$(ls -1 $BACKUP_DIR/$BASENAME*.gz | head -1)
LOG_FILE_PATH="$(ls -1 $BACKUP_DIR/$BASENAME*.gz | head -1 | cut -d. -f1-2)"".log"

if [ ! -z "$3" ]
then

    echo "File Threshold = $FILE_THRESHOLD"
    echo "Backup Directory = $BACKUP_DIR"
    echo "Backup Files Count = $BACKUP_FILES_COUNT"
    echo "List Of Files:"
    echo "$LIST_OF_FILES"
    echo "Oldest File = $OLDEST_FILE_PATH"
    echo "Log File Path = $LOG_FILE_PATH"
    echo ""

    if [ $BACKUP_FILES_COUNT -ge $FILE_THRESHOLD ]
    then
        rm -rf $OLDEST_FILE_PATH
        rm -rf $LOG_FILE_PATH
    fi


fi
