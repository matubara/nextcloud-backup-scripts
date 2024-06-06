#!/bin/bash
#####################################################################
# NEXTCLOUDバックアップスクリプト                                   #
#####################################################################
# ドキュメントルートのパスを設定
DOCUMENTROOT_PATH=/home/kusanagi/nextcloud2024_dev/DocumentRoot/

#絶対パスでスクリプトを起動するためスクリプトディレクトリのパスを指定
SCRIPT_PATH=${DOCUMENTROOT_PATH}sh/

#各種スクリプト変数定義ファイルを読み込む
source ${SCRIPT_PATH}nc_const.sh

# 正常に読み込まれているかどうか確認する
# SAVINGDAYS変数で判定
if [ ${SAVINGDAYS} -gt 1 ]; then
 1を超えている場合OKとする
else
 # 定義ファイルが正常に読み込まれていないため処理を中断する
 echo 定義ファイルが正常に読み込まれていないため処理を中断する
fi


# 計測用開始日時を取得する
_started_at=$(date +'%s.%3N')

# バックアップファイルの日付プレフィックスを作成する
SYSDATE=`date '+%Y%m%d_%H%M%S'`
echo ${SYSDATE}': Start backup for NEXTCLOUD'


# メンテナンスモードをオンにする
echo "${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --on"
${SUDO_U_HTTPD}${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --on
echo 'Maintenance mode is turned on'


# データベースのバックアップを取得する
echo データベースのバックアップを取得する
echo "mysqldump --defaults-extra-file=${SCRIPT_PATH}nc_dbaccess.conf --single-transaction --no-tablespaces ${BACKUP_DATABASE} "

#delete option --skip-column-statistics because of error
#mysqldump --defaults-extra-file=${SCRIPT_PATH}nc_dbaccess.conf --single-transaction --skip-column-statistics --no-tablespaces ${BACKUP_DATABASE} > ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql

mysqldump --defaults-extra-file=${SCRIPT_PATH}nc_dbaccess.conf --single-transaction --no-tablespaces ${BACKUP_DATABASE} > ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql
echo 'Complete database backup'
#exit 0


# フォルダのバックアップを取得する
echo フォルダのバックアップを取得する

bash ${SCRIPT_PATH}nc_backup_folder_abs.sh ${SYSDATE} config nextcloud/config
bash ${SCRIPT_PATH}nc_backup_folder_abs.sh ${SYSDATE} nextcloud nextcloud
bash ${SCRIPT_PATH}nc_backup_folder_abs.sh ${SYSDATE} data data


# 古いバックアップファイルを削除する
echo 古いバックアップファイルを削除する

find  ${BACKUP_DIR} -type f -mtime +${SAVINGDAYS} | xargs rm -f


# メンテナンスモードをオフにする
${SUDO_U_HTTPD}${PHP_CMD} ${NEXTCLOUD_DIR}occ maintenance:mode --off
echo 'Maintenance mode is turned off'



# 作成したバックアップファイルを別サーバーに転送する
echo 作成したバックアップファイルを別サーバーに転送する

sleep 3.0

${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}${SYSDATE}_config.tar ${SYSDATE}_config${SUFFIX}.tar
sleep 1.0

${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}${SYSDATE}_nextcloud.tar ${SYSDATE}_nextcloud${SUFFIX}.tar
sleep 1.0

${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql ${SYSDATE}_nextcloud_db${SUFFIX}.sql
sleep 1.0

${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}${SYSDATE}_data.tar ${SYSDATE}_data${SUFFIX}.tar
sleep 1.0

#date info
echo $SYSDATE > ${BACKUP_DIR}latestfile.txt
sleep 1.0
${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}latestfile.txt latestfile${SUFFIX}.txt
echo $SYSDATE > ${BACKUP_DIR}updatedflag.txt
sleep 1.0
${SCRIPT_PATH}scp-transfer-lib_abs.sh ${BACKUP_DIR}updatedflag.txt updatedflag${SUFFIX}.txt


# バックアップ完了通知をメールする
echo バックアップ完了通知をメールする

${PHP_CMD} ${SCRIPT_PATH}diskinfo.php ${DOCUMENTROOT_PATH} cloud2024.sincereW.online admin@sinceretechnology.com.au


# バックアップ処理完了
echo バックアップ処理完了
echo ${SYSDATE}': Completed all backup'

# 計測用終了日時を取得する
_ended_at=$(date +'%s.%3N')

# 経過時間を表示する
echo "start: $(date -d "@${_started_at}" +'%Y-%m-%d %H:%M:%S.%3N (%:z)')"
echo "end  : $(date -d "@${_ended_at}" +'%Y-%m-%d %H:%M:%S.%3N (%:z)')"
echo "dur:   $_elapsed"
eval "echo Elapsed Time: $(date -ud "$_elapsed" +'$((%s/3600/24)):%H:%M:%S.%3N')"

