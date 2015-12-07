#!/bin/bash

/home/pheanex/bin/mount_vetinari_backup.sh &&
for directory in Bilder Dokumente Studium
do
	# Check if git repo exists or create if not
	cd "/home/pheanex/Backup/${directory}" &&
	if ! git rev-parse --is-inside-work-tree &> /dev/null
	then
		git init --bare . &&
		git remote add vetinari "/home/pheanex/backup_decrypted/${directory,,}/"
	fi &&
	# Synch repo with vetinari
	git fetch --all &&
	git push -u vetinari --all
done &&
# Check if git repo exists or create if not
cd /home/pheanex/maildir &&
if ! git rev-parse --is-inside-work-tree &> /dev/null
then
	git init . &&
	git remote add vetinari "/home/pheanex/backup_decrypted/mail"
fi &&
git fetch --all &&
git checkout master &&
git add -A . &&
git commit -m "update from $(date)" &&
git push

/home/pheanex/bin/umount_vetinari_backup.sh
