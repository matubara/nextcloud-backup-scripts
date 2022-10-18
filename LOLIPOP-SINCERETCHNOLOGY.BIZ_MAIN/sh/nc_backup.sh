#pushd /home/users/2/main.jp-onlinestore/web/storage2022.sinceretechnology.com.au/sh
pushd /home/users/2/main.jp-blogdeoshiete/web/storage2022.sinceretechnology.biz/sh-blogdeoshiete

#!/bin/bash
source ./nc_const.sh


#Start date
_started_at=$(date +'%s.%3N')

SYSDATE=`date '+%Y%m%d_%H%M%S'`
echo ${SYSDATE}': Start backup for NEXTCLOUD'
#Maintenance mode ON
#${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --on
#echo 'Maintenance mode is turned on'


bash ./nc_backup_database.sh ${SYSDATE}


bash ./nc_backup_folder.sh ${SYSDATE} config nextcloud/config
bash ./nc_backup_folder.sh ${SYSDATE} nextcloud nextcloud
bash ./nc_backup_folder.sh ${SYSDATE} data data

#Maintenance mode OFF
#${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --off
#echo 'Maintenance mode is turned off'

echo "./scp-transfer-lib.sh ${BACKUP_DIR}${SYSDATE}_config.tar ${SYSDATE}_config.tar"

./scp-transfer-lib.sh ${BACKUP_DIR}${SYSDATE}_config.tar ${SYSDATE}_config.tar
sleep 1.5 
./scp-transfer-lib.sh ${BACKUP_DIR}${SYSDATE}_nextcloud.tar ${SYSDATE}_nextcloud.tar
sleep 1.5 
./scp-transfer-lib.sh ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql ${SYSDATE}_nextcloud_db.sql
sleep 1.5 
./scp-transfer-lib.sh ${BACKUP_DIR}${SYSDATE}_data.tar ${SYSDATE}_data.tar
#date info
echo $SYSDATE > ${BACKUP_DIR}latestfile.txt
sleep 1.5 
./scp-transfer-lib.sh ${BACKUP_DIR}latestfile.txt latestfile.txt
echo $SYSDATE > ${BACKUP_DIR}updatedflag.txt
sleep 1.5 
./scp-transfer-lib.sh ${BACKUP_DIR}updatedflag.txt updatedflag.txt

#Send compelte mail
echo 'Send Complete mail'
${PHP_CMD} ./diskinfo.php ${TARGET_DIR} admin@sinceretechnology.com.au
echo ${SYSDATE}': Completed all backup'

# End time
_ended_at=$(date +'%s.%3N')

echo "start: $(date -d "@${_started_at}" +'%Y-%m-%d %H:%M:%S.%3N (%:z)')"
echo "end  : $(date -d "@${_ended_at}" +'%Y-%m-%d %H:%M:%S.%3N (%:z)')"
echo "dur:   $_elapsed"
eval "echo Elapsed Time: $(date -ud "$_elapsed" +'$((%s/3600/24)):%H:%M:%S.%3N')"
popd
