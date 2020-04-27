#!/bin/sh

# find yesterdays year
YEAR=$(date -v-1d +%Y)

# find latest logfile
LATESTLOG=$(ls -1rt /usr/local/www/logs/proxytiming.json.*.xz | tail -1)

# bail out if file is not readable
if ! [ -f "${LATESTLOG}" ]; then
    echo "Logfile ${LATESTLOG} is not readable, bailing out ..."
    exit 1
fi

echo "Processing logfile ${LATESTLOG} ..."
# the awk foo sticks the hostname in front of the request uri /robots.txt -> example.com/robots.txt
xzcat ${LATESTLOG} | grep -v "logfile turned over$" | awk -F\" '{ OFS = FS } $76=$64$76' | /usr/local/bin/goaccess -p /usr/local/etc/goaccess.conf --invalid-requests=/var/log/goaccess-fail-$(basename ${LATESTLOG}).log --load-from-disk --db-path=/var/db/goaccess --keep-db-files --ignore-crawlers --anonymize-ip -o /usr/local/www/goaccess/${YEAR}.html
