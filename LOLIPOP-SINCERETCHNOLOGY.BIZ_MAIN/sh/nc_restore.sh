

SUBDOMAIN=storage2022

BASEDIR=/home/users/2/main.jp-onlinestore/web/${SUBDOMAIN}.mementoful.com/
#BACKUPDIR=/home/users/2/main.jp-onlinestore/transferred-backup/
BACKUPDIR=/home/users/2/main.jp-onlinestore/web/${SUBDOMAIN}.mementoful.com/backup/

if [ -f ${BACKUPDIR}updatedflag.txt ]; then
echo ok
#exit
    rm -f ${BACKUPDIR}updatedflag.txt
else
    echo "no updated backup!"
#    exit
fi 

#MAINTENANCE MODE OFF
#/usr/local/php/7.4/bin/php  /home/users/2/main.jp-onlinestore/web/${SUBDOMAIN}.mementoful.com/nextcloud/occ maintenance:mode --on


SYSDATE=`cat ${BACKUPDIR}latestfile.txt`_
echo "backup date=${SYSDATE}"

#FILES
tar -xf ${BACKUPDIR}${SYSDATE}nextcloud.tar
tar -xf ${BACKUPDIR}${SYSDATE}data.tar
cp -rp ./home/users/2/main.jp-onlinestore/web/storage2022.mementoful.com/nextcloud ${BASEDIR}
cp -rp ./home/users/2/main.jp-onlinestore/web/storage2022.mementoful.com/data ${BASEDIR}
cp -p ${BASEDIR}config.php ${BASEDIR}nextcloud/config 
#DATABASE
mysql -u LAA1228131 -pmelb1999 -h mysql205.phy.lolipop.lan LAA1228131-nextcloudmir < ${BACKUPDIR}${SYSDATE}nextcloud_db.sql
#MAINTENANCE MODE OFF
#/usr/local/php/7.4/bin/php  /home/users/2/main.jp-onlinestore/web/docs.mementoful.com/nextcloud/occ maintenance:mode --off
