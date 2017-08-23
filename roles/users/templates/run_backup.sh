#!/bin/bash
db_dump_file="/tmp/nextcloud-db-dump.sql"
backup_dir="backup_decrypted/"

mysqldump --single-transaction -u {{nextcloud_db_admin}} -p{{nextcloud_db_pwd}} {{nextcloud_db_name}} > "$db_dump_file"


for location in raspberry vetinari
do
	/home/pheanex/bin/mount_backup.sh "$location" || break
	cp -uv "$db_dump_file" "$backup_dir"nextcloud-db-dump.sql_new && mv -v "$backup_dir"nextcloud-db-dump.sql_new "$backup_dir"nextcloud-db-dump.sql
	cp -Ruv /home/nextcloud/ncdata/ "$backup_dir"
	cp -Ruv /home/pheanex/maildir/ "$backup_dir"
	/home/pheanex/bin/umount_backup.sh "$location" || exit 1
done

rm -f "$db_dump_file"
