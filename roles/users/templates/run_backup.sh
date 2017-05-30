#!/bin/bash
cd "${HOME}/maildir" &&
git add -A . &&
git commit -m "update from $(date)"
cd -
for backup_location in vetinari raspberry
do
	/home/pheanex/bin/mount_backup.sh "$backup_location" &&
	for dir in Backup/* maildir
	do
		cp -Ruv "$dir" backup_decrypted/
	done
	/home/pheanex/bin/umount_backup.sh "$backup_location"
done
