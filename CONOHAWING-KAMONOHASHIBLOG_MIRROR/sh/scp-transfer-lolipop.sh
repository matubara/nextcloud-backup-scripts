#SSH接続でロリポップサーバーに入る
scp -i /home/c9432556/public_html/agripark.sinceretechnology.biz/backup/.ssh/id_rsa -P 2222 $1 main.jp-cloud@ssh.lolipop.jp:/home/users/1/main.jp-cloud/web/temp

