savingdays=2
find /home/kusanagi/nextcloud2024_dev/DocumentRoot/backup -type f -mtime +${savingdays} | xargs -r ls -al >> /home/kusanagi/nextcloud2024_dev/DocumentRoot/backup/delete.log
#find /home/kusanagi/nextcloud2024_dev/DocumentRoot/backup -type f -mtime +${savingdays} | xargs rm -f
df -h >> /home/kusanagi/nextcloud2024_dev/DocumentRoot/backup/delete.log
