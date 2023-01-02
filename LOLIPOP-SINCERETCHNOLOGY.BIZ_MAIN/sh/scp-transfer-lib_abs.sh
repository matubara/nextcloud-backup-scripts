#!/bin/bash
#ドキュメントルート
DOCUMENTROOT_PATH=/home/users/2/main.jp-blogdeoshiete/web/storage2022.sinceretechnology.biz/
#スクリプトファイルがあるディレクトリ
SCRIPT_PATH=${DOCUMENTROOT_PATH}sh/
source ${SCRIPT_PATH}nc_const.sh

#######################################################################
#$BBh0l0z?t$OE>Aw85%Q%9!\%U%!%$%kL>!"BhFs0z?t$K$OE>Aw@h$N%U%!%$%kL>$r@_Dj(B
#######################################################################

SYSDATE=`date '+%Y%m%d_%H%M'`
if [ "$BACKUP_SERVER" = "conoha-kamo" ]; then

#/home/users/2/main.jp-blogdeoshiete/web/storage2022.sinceretechnology.biz/sh-blogdeoshiete

echo "   scp -i /home/users/2/main.jp-blogdeoshiete/key/kamonohashiblog-key.pem -P 8022 $1 c7657278@www256.conoha.ne.jp:/home/c7657278/TRANSFERED_FROM_LOLIPOP_SERVER/$2"

    scp -i /home/users/2/main.jp-blogdeoshiete/key/kamonohashiblog-key.pem \
        -P 8022 \
        $1 \
        c7657278@www256.conoha.ne.jp:/home/c7657278/TRANSFERED_FROM_LOLIPOP_SERVER/$2

    echo "Transferred to conoha-stech server"
elif [ "$BACKUP_SERVER" = "lolipop" ]; then
    scp -i $KEYPATH \
        -P 2222 \
        $1 \
        main.jp-onlinestore@ssh.lolipop.jp:/home/users/2/main.jp-onlinestore/transferred-backup/$2
    echo "Transferred to Lolipo server"
else
    echo "Not transferred"
fi
