#!/bin/bash
source ./nc_const.sh

SYSDATE=`date '+%Y%m%d_%H%M%S'`
echo ${SYSDATE}': NEXTCLOUD Backup script started.'
#Maintenance mode is on
${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --on
bash ./nc_backup_folder.sh ${SYSDATE} config nextcloud/config
bash ./nc_backup_folder.sh ${SYSDATE} nextcloud nextcloud
bash ./nc_backup_folder.sh ${SYSDATE} data data
bash ./nc_backup_database.sh ${SYSDATE}
echo "${SYSDATE}_" > ${BACKUPDIR}updatedflag.txt
echo "${SYSDATE}_" > ${BACKUPDIR}latestfile.txt
#Maintenance mode is off
${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --off
#Completed
echo ${SYSDATE}': NEXTCLOUD Backup script completed.'
${PHP_CMD} ./diskinfo.php ${TARGET_DIR} admin@sinceretechnology.com.au
echo ${SYSDATE}': NEXTCLOUD Sent notification via email.'
