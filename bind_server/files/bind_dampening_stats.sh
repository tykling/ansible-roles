#!/bin/sh
BASEDIR=/var/tmp/node_exporter/
PROMFILE=${BASEDIR}bind_dampening.prom
SCRIPT=$(basename "$0")
TEMPFILE=$(mktemp "${BASEDIR}""${SCRIPT}".XXXXXX) || exit 1

# initiate empty file
if [ ! -s $PROMFILE ]; then
    echo "${PROMFILE} not found, creating..."
    echo "# HELP bind_dampened_total Total number of dampened prefixes" > $PROMFILE
    echo "# TYPE bind_dampened_total gauge" >> $PROMFILE
fi

# tail log and add as we go
tail -F /var/log/bind-dampening.log | grep --line-buffered "Stats for" | while read -r line; do
   view=$(echo "$line" | sed "s/  / /" | cut -d " " -f 8 | cut -d "#" -f 1)
   damps=$(echo "$line" | sed "s/  / /" | cut -d " " -f 10)
   grep -v "$view" "$PROMFILE" > "$TEMPFILE"
   echo "bind_dampened_total{view=\"${view}\"} $damps" >> "$TEMPFILE"
   chmod 0644 "$TEMPFILE"
   mv "$TEMPFILE" "$PROMFILE"
done
