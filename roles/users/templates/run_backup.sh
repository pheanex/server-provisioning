#!/bin/bash
for backup_location in vetinari raspberry
do
	/home/pheanex/bin/mount_backup.sh "$backup_location" &&
	for directory in Bilder Dokumente Studium
	do
		rsync -crl --partial "${HOME}/Backup/${directory}" "${HOME}/backup_decrypted/"
	done &&
	cd "${HOME}/maildir" &&
	git add -A . &&
	git commit -m "update from $(date)" &&
	rsync -crl --partial "${HOME}/maildir/" "${HOME}/backup_decrypted/"

	/home/pheanex/bin/umount.sh "$backup_location"
done
