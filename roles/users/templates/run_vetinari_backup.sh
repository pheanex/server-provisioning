#!/bin/bash

/home/pheanex/bin/mount_vetinari_backup.sh &&
for directory in Bilder Dokumente Studium
do
	rsync -crl --partial "${HOME}/Backup/${directory}" "${HOME}/backup_decrypted/"
done &&
cd "${HOME}/maildir" &&
git add -A . &&
git commit -m "update from $(date)" &&
rsync -crl --partial "${HOME}/maildir/" "${HOME}/backup_decrypted/"

/home/pheanex/bin/umount_vetinari_backup.sh
