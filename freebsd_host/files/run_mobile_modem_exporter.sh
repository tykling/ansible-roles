#!/bin/sh
# run the lte_modem_exporter in a loop every $1 seconds, save output in $2,
# pass the remaining args to lte_modem_exporter.sh

# delay is first arg
delay=$1
shift

# path is second arg
path=$1
shift

# loop forever and call lte_modem_exporter.sh every $delay seconds
while true; do
    /usr/local/bin/lte_modem_exporter.sh "$@" | /usr/local/bin/sponge "${path}"/lte_modem.prom
    sleep "$delay"
done
