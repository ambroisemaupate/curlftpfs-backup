#!/bin/bash
# Ambroise Maupate <ambroise@rezo-zero.com>

# Choose a prefix to identify your website in
# your FTP backup server.
PREFIX="foo-bar";

# Make sure that folder exists
# on your server before executing this script
MOUNT="/mnt/ftpbackup";
FTPUSER="foo";
FTPPASS="bar";
FTPHOST="mybackupftp.com";

MYSQL_USER="foo"
MYSQL_PASS="foo"
MYSQL_DB="foo_db"

# Change this path to reflect your own website root.
VHOST_PATH="/var/www/vhosts/foo.bar/htdocs"

NOW="`date +"%Y-%m-%d"`";

DB_FOLDER="$MOUNT/$PREFIX/db";
FILES_FOLDER="$MOUNT/$PREFIX/files";

# Mount your FTP server as a system folder
# to enable find operations.
curlftpfs $FTPUSER:$FTPPASS@$FTPHOST $MOUNT;

# Delete old files
find $DB_FOLDER/. -type f -ctime +30 -exec rm "{}" \;
find $FILES_FOLDER/. -type f -ctime +5 -exec rm "{}" \;

mysqldump -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB | gzip > $DB_FOLDER/$NOW-$PREFIX.sql.gz;
# Compress your files in tar.gz
tar -zcvf $FILES_FOLDER/$NOW-www.tar.gz $VHOST_PATH;

umount $MOUNT;
