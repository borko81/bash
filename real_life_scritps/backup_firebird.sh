#!/bin/bash

# $1 Usrname, $2 Password, $3 Real path to base
if [[ -z "$1" || -z "$2" || -z "$3" ]];then
	echo "Enter username password and real path to database"
	exit 1
fi


# Ftp params
# 0 for enable, 1 for disable
FTP_STATUS=0
FTP_USER="potrebitel"
FTP_PASSWORD="parola"
FTP_URL="ip"
FTP_FOLDER="/test"

# Firebird params
USERNAME=$1
PASSWORD=$2
RUN=/opt/firebird/bin/gbak

# Database params
DATA_BASE=$3
FILE_NAME="${DATA_BASE##*/}"

# Backup folder params
BACKUP_FOLDER=/home/borko/backup/${FILE_NAME%%.*}

# Attach data and time to archive
DATA_TIME=`date +%d-%m-%Y-%H-%M`

# Concat file with date_time
CREATE_BACKUP=${FILE_NAME%%.*}-$DATA_TIME.fbk

# User frandly tar archive
ZIP_FILE_BACKUP=${CREATE_BACKUP%%.*}.tar.gz

# How mych archive to save
SAVE=3

# Check if folder exists and change owner
if [ ! -d $BACKUP_FOLDER ];then
	mkdir -p $BACKUP_FOLDER #&& chown -R firebird.firebird $BACKUP_FOLDER
fi

# Make backuo, then create zip file, check for delete
function show_for_delete () {
	FOR_SHOW=$(($TOTAL_FILE-$SAVE))
	for i in $(ls -d -1tr ${BACKUP_FOLDER}/* | grep tar.gz$ | head -n$FOR_SHOW);do
		echo $i | xargs rm -rf
	done
}

$RUN -g -t -b -user $USERNAME -password $PASSWORD $DATA_BASE $BACKUP_FOLDER/$CREATE_BACKUP &&
`cd $BACKUP_FOLDER` &&
`tar -czf $BACKUP_FOLDER/$ZIP_FILE_BACKUP -P $BACKUP_FOLDER/$CREATE_BACKUP` &&
`rm -rf $BACKUP_FOLDER/$CREATE_BACKUP` &&
# Calc how many file in folder
TOTAL_FILE=$(ls -d -1tr ${BACKUP_FOLDER}/* | grep tar.gz$ | wc -l)

if [ $TOTAL_FILE -gt $SAVE ];then
	show_for_delete
else
	echo "OK"
fi

# Send file to ftp server, server is WINDOWS, next line is configuret for Windows ftp
if [ $FTP_STATUS -eq 1 ];then
	ATTACH=`echo -n -e "put ${ZIP_FILE_BACKUP}\n"`
	cd $BACKUP_FOLDER &&
	ftp -ivn $FTP_URL <<EOF
	quote USER $FTP_USER
	quote PASS $FTP_PASSWORD
	binary
	cd $FTP_FOLDER
	$ATTACH
	quit
EOF
fi
