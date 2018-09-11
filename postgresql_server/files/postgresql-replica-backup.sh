#!/bin/sh

# pause WAL streaming replication playback
/usr/local/bin/psql -c "SELECT pg_xlog_replay_pause();"

if [ $? -ne 0 ]; then
	echo "unable to pause WAL playback, bailing out"
	exit 1
fi

# do the backup by running the daily periodic script
daily_pgsql_backup_enable=YES /usr/local/etc/periodic/daily/502.pgsql

# resume WAL streaming replication playback
/usr/local/bin/psql -c "SELECT pg_xlog_replay_resume();"

