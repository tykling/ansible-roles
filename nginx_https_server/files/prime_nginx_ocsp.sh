#!/bin/sh
for vhost in $(ls -1 /usr/local/etc/nginx/vhosts/*https.conf | rev | cut -d "/" -f 1 | rev | sed "s/-https.conf$//"); do
        /usr/bin/fetch -qo /dev/null https://${vhost}/__nginx_ocsp_priming/ 2>/dev/null
done
