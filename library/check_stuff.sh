#!/bin/sh

# the main function
check_inventory() {
        # find unique hosts in ansible inventory file and loop over them
        for host in $(grep -Ev "(\\[|^#|^$)" "$1" | cut -w -f 1 | sort | uniq); do
                # get the pkg audit output, run with -F to ensure we have a fresh vuln xml
                output=$(/usr/local/bin/ansible "$host" -m shell -b -a "/usr/sbin/pkg audit -F" -i "$1")
                if [ $? -ne 0 ]; then
                        # vulns found, or ansible could not connect, send email regardless
                        echo "$output" | /usr/bin/mail -s "$(basename "$1") - $host: Vulnerable packages found!" "$2"
                fi

                # get the sshfp output
                output=$(/usr/local/bin/python /usr/home/ansible/check_sshfp/check_sshfp $host)
                if [ $? -ne 0 ]; then
                        # sshfp issues found, send mail
                        echo "$output" | /usr/bin/mail -s "$(basename "$1") - $host: SSHFP issues found!" "$2"
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

