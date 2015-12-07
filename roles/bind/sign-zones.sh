#!/bin/bash
main_dir="$(readlink -f $0)"
main_dir="${main_dir%/*}"

zones[0]="manna.koeln"
zones[1]="manna.uno"
zones[2]="pheanex.de"

# Read in vault password
read -s -p "vault password:" password
echo
tmp_pwd_file="$(mktemp)"
chmod go-rwx "$tmp_pwd_file"
echo -n "$password" > "$tmp_pwd_file"

tmpdir="$(mktemp -d)"

# Decrypt and copy keys to tmp
(for keyfile in "${main_dir}/bind-keys/"*
do
	keyfile_basename=${keyfile##*/}
	echo "Decrypting ${keyfile_basename} ..."
	if ! ansible-vault view --vault-password-file="$tmp_pwd_file" "$keyfile" > "${tmpdir}/${keyfile_basename}"
	then
		echo "Could not decrypt ${keyfile}. Probably wrong password."
		exit 1
	fi
done) &&

# Copy zone files to tmp
(for zonefile in "${zones[@]}"
do
	cp "${main_dir}/templates/${zonefile}" "$tmpdir" || exit 1
done) &&

# Sign zones
cd "$tmpdir" &&
(for zone in "${zones[@]}"
do
	echo "Signing $zone"
	/usr/sbin/dnssec-signzone -3 91424018aecb6087 -A -N INCREMENT -o "$zone" -t "$zone" || exit 1
	mv "${zone}.signed" "${main_dir}/templates/" || exit 1
done) &&
# Copy signed zone files back to templates
(for zone in "${zones[@]}"
do
	echo "Checking zone zone-file ${zone}.signed"
	/usr/sbin/named-checkzone "$zone" "${main_dir}/templates/${zone}.signed" || exit 1
done) &&

# Cleanup
echo &&
echo Signing SUCCESSFULL >&2 || echo Signing FAILED >&2

[[ -d "$tmpdir" ]] && rm -rf "$tmpdir"
[[ -e "$tmp_pwd_file" ]] && rm -f "$tmp_pwd_file"
