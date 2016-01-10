#!/bin/bash

/home/pheanex/bin/mount_vetinari_backup.sh &&
for directory in Bilder Dokumente Studium
do
	rsync -crlpEADPXv "${HOME}/Backup/${directory}" "${HOME}/backup_decrypted/${directory}"
done &&
cd "${HOME}/maildir" &&
git add -A . &&
git commit -m "update from $(date)" &&
rsync -crlpEADPXv "${HOME}/maildir/" "${HOME}/backup_decrypted/maildir"

/home/pheanex/bin/umount_vetinari_backup.sh
