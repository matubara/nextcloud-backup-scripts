source ./nc_const.sh

#######################################################################
#$BBh0l0z?t$OE>Aw85%Q%9!\%U%!%$%kL>!"BhFs0z?t$K$OE>Aw@h$N%U%!%$%kL>$r@_Dj(B
#######################################################################

SYSDATE=`date '+%Y%m%d_%H%M'`
#SSH$B@\B3$G%m%j%]%C%W%5!<%P!<$KF~$k(B
#scp -i /home/c9432556/public_html/agripark.sinceretechnology.biz/backup/.ssh/id_rsa -P 2222 $1 main.jp-cloud@ssh.lolipop.jp:/home/users/1/main.jp-cloud/web

#scp  -P 2222 $1 main.jp-onlinestore@ssh.lolipop.jp:/home/users/2/main.jp-onlinestore/backup

#scp -i ./id_rsa -P 2222 $1 main.jp-onlinestore@ssh.lolipop.jp:/home/users/2/main.jp-onlinestore/backup

#SSH$B@\B3$G(BCONOHAWING$B%5!<%P!<(B(S-TECH)$B$KAw?.$9$k(B
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
