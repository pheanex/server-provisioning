#!/bin/bash
# This script mount a remote dir through sshfs and uses encfs to encrypt stuff
# (Keep in mind that before you can use this, you need to initialize the encfs first)

. /home/pheanex/vetinari.mount-options

if [[ -d "$sshfs_local_dir" ]]
then
	echo "Error: ssh local dir \"$sshfs_local_dir\" already exists" >&2
	exit 1
fi

if [[ -d "$encfs_decrypted_dir" ]]
then
	echo "Error: encfs mountpoint \"$encfs_decrypted_dir\" already exists" >&2
	exit 1
fi

mkdir "$sshfs_local_dir" "$encfs_decrypted_dir"

# Mount SSHFS
sshfs "${sshfs_remote_user}@${sshfs_remote_host}:${sshfs_remote_dir}" "$sshfs_local_dir" -o IdentityFile="$sshfs_remote_user_key" -o uid="$(id -u $(whoami))" -o gid="$(id -g $(whoami))" &&

# Mount EncFS
echo "$password" | encfs "$sshfs_local_dir" "$encfs_decrypted_dir" -S
