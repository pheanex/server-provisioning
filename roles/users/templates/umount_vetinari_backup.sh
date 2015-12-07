#!/bin/bash
# unmounts the sshfs and encfs

. /home/pheanex/vetinari.mount-options

[[ -d "$encfs_decrypted_dir" ]] && fusermount -u "$encfs_decrypted_dir"
[[ -d "$sshfs_local_dir" ]] && fusermount -u "$sshfs_local_dir"

[[ -d "$encfs_decrypted_dir" ]] && rmdir "$encfs_decrypted_dir"
[[ -d "$sshfs_local_dir" ]] && rmdir "$sshfs_local_dir"
