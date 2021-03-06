#!/bin/bash

# Overwrite vars-file
vars_file="vars/certs_keys.yml"
>| "$vars_file"

for domain in "manna.uno" "pheanex.de"
do
	# Generate Keys and certs
	openssl req -x509 -nodes -new -keyout "${domain}.key.pem" -out "${domain}.crt.pem" -config "${domain}.openssl.cnf" -days 730

	# Generate templates
	echo -n "{{${domain//./_}_crt_pem}}" > "templates/${domain}.crt.pem.j2"
	echo -n "{{${domain//./_}_key_pem}}" > "templates/${domain}.key.pem.j2"

	# Generate vars with ansible-vault
	{
		echo "${domain//./_}_crt_pem: |"
		sed 's/^/  /' "${domain}.crt.pem"
		echo
		echo
		echo "${domain//./_}_key_pem: |"
		sed 's/^/  /' "${domain}.key.pem"
		echo
		echo
	} >> $vars_file

	# Generate hash of cert
	openssl x509 -in "${domain}.crt.pem" -outform DER | openssl sha512 | awk '{print $2}' > "${domain}.crt.hash"

	# Delete original key- and cert-files
	rm "${domain}.key.pem" "${domain}.crt.pem"
done

# Encrypt vars-file with ansible-vault
ansible-vault encrypt --vault-password-file ~/.ansible-vault-pw "$vars_file"

# Remind user to update TLSA records (DANE) in bind zone-files
echo
echo "Update the hases in the bind zone-files" >&2
for domain in "manna.uno" "pheanex.de"
do
	echo "In the ${domain}-zone: $(cat "${domain}.crt.hash")"
done

# Cleanup hashes
for domain in "manna.uno" "pheanex.de"
do
	rm "${domain}.crt.hash"
done
