#!/bin/bash
source ./nc_const.sh

SYSDATE=`date '+%Y%m%d_%H%M%S'`
echo ${SYSDATE}': NEXTCLOUDのバックアップを開始します'
#メンテナンスモードにする
php ${NEXTCLOUD_DIR}occ maintenance:mode --on
bash ./nc_backup_database.sh ${SYSDATE}
bash ./nc_backup_folder.sh ${SYSDATE} config nextcloud/config
bash ./nc_backup_folder.sh ${SYSDATE} nextcloud nextcloud
bash ./nc_backup_folder.sh ${SYSDATE} data data
#メンテナンスモードを解除する
php ${NEXTCLOUD_DIR}occ maintenance:mode --off
#完了メールを送信する
echo '完了メールを送信します'
php ./diskinfo.php ${TARGET_DIR} admin@sinceretechnology.com.au
echo ${SYSDATE}': すべてのバックアップが完了しました'
