
# パスの設定
DOCUMENTROOT_PATH=/home/kusanagi/nextcloud2024_dev/DocumentRoot/

# バックアップファイルが格納されているファイルを設定する
BACKUP_DIR=${DOCUMENTROOT_PATH}backup/

# NEXTCLOUDフォルダを設定する
NEXTCLOUD_DIR=${DOCUMENTROOT_PATH}nextcloud/

# php実行ファイルが格納されているパスを指定する
PHP_CMD="/opt/kusanagi/php/bin/php"

# sudoコマンドで実行ユーザをhttpdに指定する
SUDO_U_HTTPD="sudo -u httpd "

# バックアップ対象データベース名を指定する
BACKUP_DATABASE=nextcloud2024

# バックアップデータ転送先サーバー指定を指定する
# （scp-transfer-lib_abs.shで使用）
#BACKUP_SERVER=conoha-studypocket
BACKUP_SERVER=lolipop

# バックアップ保持日数を設定する（下記指定日数より古いファイルは削除される）
SAVINGDAYS=2

# バックアップファイルにサフィックスがある場合は指定
SUFFIX="_online"
# ちなみにファイル名は以下の通り
# 更新済みかどうか updatedflag{固定サフィックス}.txt
# バックアップ日付（ファイル名のプリフィックス） latestfile{固定サフィックス}.txt
# NEXTCLOUDフォルダ圧縮ファイル {バックアップ日付}nextcloud{固定サフィックス}.tar
# DATAフォルダ圧縮ファイル {バックアップ日付}data{固定サフィックス}.tar
# バックアップ日付SUFFIX latestfile{固定サフィックス}.txt
