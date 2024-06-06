#!/bin/bash
#ドキュメントルート
DOCUMENTROOT_PATH=/home/kusanagi/nextcloud2024_dev/DocumentRoot/
#スクリプトファイルがあるディレクトリ
SCRIPT_PATH=${DOCUMENTROOT_PATH}sh/
#source ${SCRIPT_PATH}nc_const.sh
source ${SCRIPT_PATH}scp_const.sh

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
elif [ "$BACKUP_SERVER" = "conoha-studypocket" ]; then

#/home/users/2/main.jp-blogdeoshiete/web/storage2022.sinceretechnology.biz/sh-blogdeoshiete


    scp -i /home/kusanagi/key/vps-sinceretechnology.pem \
        -P 8022 \
        $1 \
        c4389980@www1041.conoha.ne.jp:/home/c4389980/TRANSFERED_FROM_LOLIPOP_SINCERE_SERVER/$2

    echo "Transferred to conoha-stech server"
elif [ "$BACKUP_SERVER" = "lolipop" ]; then
    scp -i /home/kusanagi/key/id_lolipop_sincerew \
        -P 2222 \
        $1 \
        main.jp-sincerewill@ssh.lolipop.jp:/home/users/1/main.jp-sincerewill/TRANSFERED_FROM_LOLIPOP_SINCERE_SERVER/$2
    echo "Transferred to Lolipo server"
else
    echo "Not transferred"
fi
