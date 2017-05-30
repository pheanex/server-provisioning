#!/bin/bash
cd "${HOME}/maildir" &&
git add -A . &&
git commit -m "update from $(date)" &&
cd - &&
cp -R maildir/ Backup/ &&
for backup_location in vetinari raspberry
do
	/home/pheanex/bin/mount_backup.sh "$backup_location" &&
	for dir in Backup/*
	do
		cp -Ruv "$dir" backup_decrypted/
	done
	/home/pheanex/bin/umount_backup.sh "$backup_location"
done
