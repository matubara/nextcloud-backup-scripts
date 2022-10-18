source ./nc_const.sh

if [ $# -eq 3 ]; then
  SYSDATE=$1
  TARFILE_NAME=$2
  DIR_NAME=$3
  TARGET_DIR=${DOCUMENTROOT_PATH}${DIR_NAME}/
  #echo "tar -cf ${BACKUP_DIR}${SYSDATE}_${DIR_NAME}.tar ${TARGET_DIR}"
  tar -cf ${BACKUP_DIR}${SYSDATE}_${TARFILE_NAME}.tar ${TARGET_DIR}
  echo "${DIR_NAME}フォルダのバックアップを完了しました。"
else
  echo '引数が不正です'
fi

