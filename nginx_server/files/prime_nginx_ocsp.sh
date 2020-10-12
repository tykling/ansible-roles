#!/bin/sh
for vhost in $(find /usr/local/etc/nginx/vhosts/ -type f -name '*https.conf' | rev | cut -d "/" -f 1 | rev | sed "s/-https.conf$//"); do
        echo -e "GET /__nginx_ocsp_priming/ HTTP/1.1\r\nhost: ${vhost}\r\n" | /usr/local/bin/openssl s_client -connect ${vhost}:443 -servername ${vhost} -status > /dev/null 2>&1
done
