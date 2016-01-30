#!/bin/bash

/home/pheanex/bin/mount_vetinari_backup.sh &&
for directory in Bilder Dokumente Studium
do
	rsync -crlpEADPX "${HOME}/Backup/${directory}" "${HOME}/backup_decrypted/"
done &&
cd "${HOME}/maildir" &&
git add -A . &&
git commit -m "update from $(date)" &&
rsync -crlpEADPX "${HOME}/maildir/" "${HOME}/backup_decrypted/"

/home/pheanex/bin/umount_vetinari_backup.sh
