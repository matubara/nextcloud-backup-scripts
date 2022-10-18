NEXTCLOUD_DIR=`pwd`/../nextcloud/
ls $NEXTCLOUD_DIR
p="/usr/local/php/7.4/bin/php"
$p ${NEXTCLOUD_DIR}occ maintenance:mode --off
$p ${NEXTCLOUD_DIR}occ maintenance:mode --on

