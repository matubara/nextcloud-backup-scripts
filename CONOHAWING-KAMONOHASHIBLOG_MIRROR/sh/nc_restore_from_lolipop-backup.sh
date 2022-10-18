
DOMAIN=docs.sinceretechnology.biz

BASEDIR=/home/c9432556/public_html/${DOMAIN}/
BACKUPDIR=/home/c9432556/TRANSFERED_FROM_KAMONOHASHI-SERVER-STORAGE2022/

SRCBACKUPDIR=./home/users/2/main.jp-onlinestore/web/storage2022.sinceretechnology.com.au/

DBUSER=6bolb_test1111
DBPASSWORD="Melb#1999"
DBHOST=mysql1.conoha.ne.jp
DBNAME=6bolb_test1111

if [ -f ${BACKUPDIR}updatedflag.txt ]; then
    rm -f ${BACKUPDIR}updatedflag.txt
else
    echo "no updated backup!"
    exit
fi

#MAINTENANCE MODE OFF
#php  /home/users/2/main.jp-onlinestore/web/${DOMAIN}/nextcloud/occ maintenance:mode --on


SYSDATE=`cat ${BACKUPDIR}latestfile.txt`_
echo "backup date=${SYSDATE}"

#FILES
tar -xf ${BACKUPDIR}${SYSDATE}nextcloud.tar
tar -xf ${BACKUPDIR}${SYSDATE}data.tar
cp -rp ${SRCBACKUPDIR}nextcloud ${BASEDIR}
cp -rp ${SRCBACKUPDIR}data ${BASEDIR}
cp -p ${BASEDIR}config.php ${BASEDIR}nextcloud/config
#DATABASE
echo "mysql -u 6bolb_test1111 -pMelb#1999 -h mysql1.conoha.ne.jp 6bolb_test1111 < ${BACKUPDIR}${SYSDATE}nextcloud_db.sql"
mysql -u ${DBUSER} -p${DBPASSWORD} -h ${DBHOST} ${DBNAME} < ${BACKUPDIR}${SYSDATE}nextcloud_db.sql
#MAINTENANCE MODE OFF
#php  /home/users/2/main.jp-onlinestore/web/${DOMAIN}/nextcloud/occ maintenance:mode --off
echo complete restore
