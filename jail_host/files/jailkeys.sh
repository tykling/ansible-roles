#!/bin/sh
#########################################################
# jailkeys.sh is a script to dump ansible yaml containing
# certgrinder ssh keys, hostnames and IP addresses for
# all jails on a jailhost in a format which is suitable
# for addition to a certgrinderd servers ansible host_keys
#
# Part of https://github.com/tykling/ansible-roles
#####################################################
find /usr/jails/*/usr/local/etc/certgrinder/.ssh/ -name "id_*.pub" -exec cat {} \; | while read -r KEY; do 
        HOSTNAME=$(echo "$KEY" | cut -d " " -f 3 | cut -d "@" -f 2)
        SNAKENAME=$(echo "$HOSTNAME" | tr "." "_")

cat << EOF
  $SNAKENAME:
    fromip:
      - "$(dig +short "$HOSTNAME" A)"
      - "$(dig +short "$HOSTNAME" AAAA)"
    authkey: "$KEY"
    domainsets:
      - "$HOSTNAME"

EOF

done
