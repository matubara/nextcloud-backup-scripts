source ./nc_const.sh

if [ $# -eq 1 ]; then
SYSDATE=$1
mysqldump --defaults-extra-file=./nc_dbaccess.conf --single-transaction --single-transaction ${BACKUP_DATABASE} > ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql
echo 'データベースバックアップを完了しました'
else
  echo '引数が不正です'
fi
