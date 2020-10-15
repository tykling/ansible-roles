#!/bin/sh

# the main function
check_inventory() {
	for HOST in $(/usr/local/bin/ansible all -i "${INVENTORY}" --list-HOSTs 2> /dev/null | cut -c 5- | /usr/bin/egrep "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)+([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$"); do
                # pkg audit check moved to prometheus/alertmanager through pkg_exporter.sh and node_exporter textfile collector

                # get the sshfp output
                output=$(/usr/local/bin/python /usr/home/ansible/check_sshfp/check_sshfp $HOST)
                if [ $? -ne 0 ]; then
                        # sshfp issues found, send mail
                        echo "$output" | /usr/bin/mail -s "$(basename "$1") - $HOST: SSHFP issues found!" "$2"
                fi
        done
}

# do we have an email?
if [ $# -ne 1 ]; then
        echo "usage: $0 <email>"
        exit 1
fi

# loop over inventory files and check them
for file in /usr/local/etc/ansible/*_hosts /usr/local/etc/ansible/*_hosts.yml; do
        check_inventory "$file" "$1"
done
