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

#UNCOMPRESS&DEPLOY FILES
echo "RESTORE NEXTCLOUD FOLDER"
read -p "Press [Enter] key to move on to the next."
#nextcloud folder
rm -rf .${DOCUMENTROOT_IN_BACKUPFILE}nextcloud
tar xfmp ${BACKUPDIR}${SYSDATE}nextcloud.tar
cp -rp .${DOCUMENTROOT_IN_BACKUPFILE}nextcloud ${DOCUMENTROOT_PATH}
rm -rf .${DOCUMENTROOT_IN_BACKUPFILE}nextcloud


#data folder
echo "RESTORE DATA FOLDER"
read -p "Press [Enter] key to move on to the next."

echo "DELETE DATA FOLDER FROM SYSTEM"
rm -rf .${DOCUMENTROOT_IN_BACKUPFILE}data
#容量不足のためデータフォルダを削除する
rm -rf ${DOCUMENTROOT_PATH}data

#バックアップファイルからデータフォルダを展開する
echo "EXPAND DATA FOLDER TO TEMPORALLY FOLDER"
tar xfmp ${BACKUPDIR}${SYSDATE}data.tar

echo "MOVE DATA FOLDER TO SYSTEM"
#容量不足のためデータフォルダを削除する(直前に再実行)
rm -rf ${DOCUMENTROOT_PATH}data
#解凍されたデータフォルダを本来の場所に移動する（コピーすると容量不足になる）
mv .${DOCUMENTROOT_IN_BACKUPFILE}data ${DOCUMENTROOT_PATH}

read -p "Press [Enter] key to move on to the next."
rm -rf .${DOCUMENTROOT_IN_BACKUPFILE}data
#config file
cp -p ${DOCUMENTROOT_PATH}config.php ${DOCUMENTROOT_PATH}nextcloud/config 

echo "RESTORE DATABASE"
read -p "Press [Enter] key to move on to the next."
#DATABASE
mysql -u LAA1467345 -pmelb1999 -h mysql207.phy.lolipop.lan LAA1467345-storage2022 < ${BACKUPDIR}${SYSDATE}nextcloud_db.sql
#MAINTENANCE MODE OFF
#/usr/local/php/7.4/bin/php  /home/users/2/main.jp-blogdeoshiete/web/docs.sinceretechnology.biz/nextcloud/occ maintenance:mode --off
echo "COMPLETED"
