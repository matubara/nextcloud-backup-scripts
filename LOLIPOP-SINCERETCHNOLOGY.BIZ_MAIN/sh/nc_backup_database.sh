source ./nc_const.sh

if [ $# -eq 1 ]; then
SYSDATE=$1
echo "mysqldump --defaults-extra-file=./nc_dbaccess.conf --single-transaction --single-transaction ${BACKUP_DATABASE} > ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql"
mysqldump --defaults-extra-file=./nc_dbaccess.conf --single-transaction --skip-column-statistics --no-tablespaces ${BACKUP_DATABASE} > ${BACKUP_DIR}${SYSDATE}_nextcloud_db.sql
echo 'Complete database backup'
else
  echo 'Database backup is not done'
fi
