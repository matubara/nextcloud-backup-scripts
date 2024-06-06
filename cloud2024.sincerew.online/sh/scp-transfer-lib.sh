source ./nc_const.sh

#######################################################################
#第一引数は転送元パス＋ファイル名、第二引数には転送先のファイル名を設定
#######################################################################

SYSDATE=`date '+%Y%m%d_%H%M'`
#SSH接続でロリポップサーバーに入る
#scp -i /home/c9432556/public_html/agripark.sinceretechnology.biz/backup/.ssh/id_rsa -P 2222 $1 main.jp-cloud@ssh.lolipop.jp:/home/users/1/main.jp-cloud/web

#scp  -P 2222 $1 main.jp-onlinestore@ssh.lolipop.jp:/home/users/2/main.jp-onlinestore/backup

#scp -i ./id_rsa -P 2222 $1 main.jp-onlinestore@ssh.lolipop.jp:/home/users/2/main.jp-onlinestore/backup

#SSH接続でCONOHAWINGサーバー(S-TECH)に送信する
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
