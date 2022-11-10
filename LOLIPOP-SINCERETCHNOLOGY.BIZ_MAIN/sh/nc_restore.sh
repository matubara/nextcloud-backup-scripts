DOCUMENTROOT_PATH=/home/users/2/main.jp-blogdeoshiete/web/storage2022.sinceretechnology.biz/

BACKUPDIR=${DOCUMENTROOT_PATH}backup/
DOCUMENTROOT_IN_BACKUPFILE=/home/users/2/main.jp-blogdeoshiete/web/storage2022.sinceretechnology.biz/

if [ -f ${BACKUPDIR}updatedflag.txt ]; then
echo ok
#exit
    rm -f ${BACKUPDIR}updatedflag.txt
else
    echo "no updated backup!"
#    exit
fi 

#MAINTENANCE MODE OFF
#/usr/local/php/7.4/bin/php  /home/users/2/main.jp-blogdeoshiete/web/${SUBDOMAIN}.sinceretechnology.biz/nextcloud/occ maintenance:mode --on


SYSDATE=`cat ${BACKUPDIR}latestfile.txt`_
echo "backup date=${SYSDATE}"

#FILES
tar -xf ${BACKUPDIR}${SYSDATE}nextcloud.tar
tar -xf ${BACKUPDIR}${SYSDATE}data.tar
cp -rp .${DOCUMENTROOT_IN_BACKUPFILE}nextcloud ${DOCUMENTROOT_PATH}
cp -rp .${DOCUMENTROOT_IN_BACKUPFILE}data ${DOCUMENTROOT_PATH}
cp -p ${DOCUMENTROOT_PATH}config.php ${DOCUMENTROOT_PATH}nextcloud/config 
#DATABASE
mysql -u LAA1467345 -pmelb1999 -h mysql207.phy.lolipop.lan LAA1467345-storage2022 < ${BACKUPDIR}${SYSDATE}nextcloud_db.sql
#MAINTENANCE MODE OFF
#/usr/local/php/7.4/bin/php  /home/users/2/main.jp-blogdeoshiete/web/docs.sinceretechnology.biz/nextcloud/occ maintenance:mode --off
