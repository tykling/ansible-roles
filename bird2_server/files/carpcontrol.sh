#!/usr/local/bin/bash
# CARP control script called by devd on CARP state change
# Used to give bird2 a list of all CARP MASTER interfaces
# Part of https://github.com/tykling/ansible-roles/tree/master/bird2_server
FILENAME=/usr/local/etc/bird-carp-master-interfaces.conf
TMPFILE=`mktemp /tmp/$(basename $0).XXXXXX` || exit 1
for interface in $(/sbin/ifconfig -l -u); do
        /sbin/ifconfig $interface | grep -q "carp: MASTER"
        if [ $? -eq 0 ]; then
                echo "interface \"$interface\";" >> $TMPFILE
        fi
done
/usr/bin/diff -u $FILENAME $TMPFILE | /usr/bin/tee >(/usr/bin/mail -s "CARP interface $1 on $(/bin/hostname) became $2 at $(/bin/date)" {{ ansible_admin_email }}) >(/usr/bin/logger -t carp)
mv $TMPFILE $FILENAME
/usr/local/sbin/birdc configure
