#!/usr/bin/bash
src=net.au
dst=biz
    echo "nextcloud/config/config.phpで設定されている対象ドメイン名を${src}から${dst}に変更します"
    echo "よろしいですか？"
    read -p "ok? (y/N): " yn
    case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac
# change top level domain
sed -i "s/${src}/${dst}/" ./nextcloud/config/config.php
cp ./config.php ./config.php.bak
cp ./nextcloud/config/config.php ./config.php
