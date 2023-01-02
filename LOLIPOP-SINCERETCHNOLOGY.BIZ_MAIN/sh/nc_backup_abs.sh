#!/bin/bash
#ドキュメントルート
DOCUMENTROOT_PATH=/home/users/2/main.jp-blogdeoshiete/web/storage2022.sinceretechnology.biz/
#スクリプトファイルがあるディレクトリ
SCRIPT_PATH=${DOCUMENTROOT_PATH}sh/
source ${SCRIPT_PATH}nc_const.sh


#Start date
_started_at=$(date +'%s.%3N')

SYSDATE=`date '+%Y%m%d_%H%M%S'`
echo ${SYSDATE}': Start backup for NEXTCLOUD'

#Maintenance mode ON
echo "${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --on"
${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --on
echo 'Maintenance mode is turned on'


#データベースのバックアップを取得する
#bash ${SCRIPT_PATH}nc_backup_database.sh ${SYSDATE}
echo "mysqldump --defaults-extra-file=${SCRIPT_PATH}nc_dbaccess.conf --single-transaction --single-transaction ${BACKUP_DATABASE} > ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql"
mysqldump --defaults-extra-file=${SCRIPT_PATH}nc_dbaccess.conf --single-transaction --skip-column-statistics --no-tablespaces ${BACKUP_DATABASE} > ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql
echo 'Complete database backup'

#フォルダのバックアップを取得する
bash ${SCRIPT_PATH}nc_backup_folder_abs.sh ${SYSDATE} config nextcloud/config
bash ${SCRIPT_PATH}nc_backup_folder_abs.sh ${SYSDATE} nextcloud nextcloud
bash ${SCRIPT_PATH}nc_backup_folder_abs.sh ${SYSDATE} data data

#Maintenance mode OFF
echo "${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --off"
${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --off
echo 'Maintenance mode is turned off'

sleep 3

#バックアップサーバーでデータを転送する
echo "${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}${SYSDATE}_config.tar ${SYSDATE}_config.tar"
${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}${SYSDATE}_config.tar ${SYSDATE}_config.tar
sleep 1.5 
${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}${SYSDATE}_nextcloud.tar ${SYSDATE}_nextcloud.tar
sleep 1.5 
${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql ${SYSDATE}_nextcloud_db.sql
sleep 1.5 
${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}${SYSDATE}_data.tar ${SYSDATE}_data.tar

#date info
echo $SYSDATE > ${BACKUP_DIR}latestfile.txt
sleep 1.5 
${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}latestfile.txt latestfile.txt
echo $SYSDATE > ${BACKUP_DIR}updatedflag.txt
sleep 1.5 
${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}updatedflag.txt updatedflag.txt


#Send compelte mail
echo 'Send Complete mail'
${PHP_CMD} ${SCRIPT_PATH}diskinfo.php ${DOCUMENTROOT_PATH} storage2022.sinceretechnology.biz admin@sinceretechnology.com.au
echo ${SYSDATE}': Completed all backup'

# End time
_ended_at=$(date +'%s.%3N')

echo "start: $(date -d "@${_started_at}" +'%Y-%m-%d %H:%M:%S.%3N (%:z)')"
echo "end  : $(date -d "@${_ended_at}" +'%Y-%m-%d %H:%M:%S.%3N (%:z)')"
echo "dur:   $_elapsed"
eval "echo Elapsed Time: $(date -ud "$_elapsed" +'$((%s/3600/24)):%H:%M:%S.%3N')"

