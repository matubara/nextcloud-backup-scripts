
DOMAIN=storage2022.kamonohashiblog.com

BASEDIR=/home/c7657278/public_html/${DOMAIN}/
BACKUPDIR=/home/c7657278/TRANSFERED_FROM_LOLIPOP_SERVER/

SRCBACKUPDIR=./home/users/2/main.jp-blogdeoshiete/web/storage2022.sinceretechnology.biz/

DBUSER=99qao_storage2022 
DBPASSWORD="Melb#1999"
DBHOST=mysql76.conoha.ne.jp
DBNAME=99qao_storage2022 

if [ -f ${BACKUPDIR}updatedflag.txt ]; then
    rm -f ${BACKUPDIR}updatedflag.txt
else
    echo "no updated backup!"
    #exit
fi

#MAINTENANCE MODE OFF
#php  /home/users/2/main.jp-onlinestore/web/${DOMAIN}/nextcloud/occ maintenance:mode --on


SYSDATE=`cat ${BACKUPDIR}latestfile.txt`_
echo "backup date=${SYSDATE}"

#FILES
tar xfmp ${BACKUPDIR}${SYSDATE}nextcloud.tar
tar xfmp ${BACKUPDIR}${SYSDATE}data.tar
cp -rp ${SRCBACKUPDIR}nextcloud ${BASEDIR}
cp -rp ${SRCBACKUPDIR}data ${BASEDIR}
cp -p ${BASEDIR}config.php ${BASEDIR}nextcloud/config
#DATABASE
echo "mysql -u 99qao_storage2022 -pMelb#1999 -h mysql76.conoha.ne.jp 99qao_storage2022 < ${BACKUPDIR}${SYSDATE}nextcloud_db.sql"
mysql -u ${DBUSER} -p${DBPASSWORD} -h ${DBHOST} ${DBNAME} < ${BACKUPDIR}${SYSDATE}nextcloud_db.sql
#MAINTENANCE MODE OFF
#php  /home/users/2/main.jp-onlinestore/web/${DOMAIN}/nextcloud/occ maintenance:mode --off
echo complete restore
