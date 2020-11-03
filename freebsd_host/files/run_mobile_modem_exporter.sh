#!/bin/sh
# run the mobile_modem_exporter in a loop every $1 seconds, save output in $2,
# pass the remaining args to mobile_modem_exporter.sh

# delay is first arg
delay=$1
shift

# path is second arg
path=$1
shift

# loop forever and call mobile_modem_exporter.sh every $delay seconds
while true; do
    /usr/local/bin/mobile_modem_exporter.sh "$@" | /usr/local/bin/sponge "${path}"/mobile_modem.prom
    sleep "$delay"
done
