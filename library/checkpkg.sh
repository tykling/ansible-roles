#!/bin/sh

# the main function
check_inventory() {
        # find unique hosts and loop over them
        for host in $(grep -Ev "(\\[|^#|^$)" "$1" | sort | uniq); do
                # get the pkg audit output, run with -F to ensure we have a fresh vuln xml
                cmd="ansible \"$host\" -m shell -b -a \"/usr/sbin/pkg audit -F\" -i \"$1\""
                if ! output=$(cmd); then
                        # vulns found, or ansible could not connect, send email regardless
                        echo "$output" | mail -s "$(basename "$1") - $host: Vulnerable packages found!" "$2"
                fi
        done
}

# do we have an email?
if [ $# -ne 1 ]; then
        echo "usage: $0 <email>"
        exit 1
fi

# loop over inventory files and check them
for file in /usr/local/etc/ansible/*_hosts; do
        check_inventory "$file" "$1"
done

