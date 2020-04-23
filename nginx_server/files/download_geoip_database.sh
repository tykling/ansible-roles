#!/bin/sh
##########################################
# Download new mmdb from db-ip.com,
# check file validity, unpack and update
# the symlink. Run from cron monthly.
#
# Public domain, use as you wish.
#
# /Tykling, April 2020.
##########################################

# define paths
TMPPATH=/tmp
GZIPFILENAME=dbip-city-lite-$(date +"%Y-%m").mmdb.gz
MMDBFILENAME=dbip-city-lite-$(date +"%Y-%m").mmdb
LINKNAME=db-ip.mmdb
DBPATH=/var/db/geoip

# Do we have somewhere to put the database? create if not..
if [ ! -d $DBPATH ]; then
        echo "DBPATH ${DBPATH} not found, creating..."
        mkdir $DBPATH
        if [ $? -ne 0 ]; then
                echo "Unable to create DBPATH ${DBPATH}, bailing out!"
                exit 1
        fi
fi

# OK, now get the actual file
fetch -qo ${TMPPATH}/${GZIPFILENAME} https://download.db-ip.com/free/${GZIPFILENAME}
if [ $? -ne 0 ]; then
        echo "There was a problem downloading the new geoip db, bailing out!"
        exit 1
fi

# Now check that we have a valid gz
if gzip -t ${TMPPATH}/${GZIPFILENAME}; then
        # File is valid, move to final location
        mv ${TMPPATH}/${GZIPFILENAME} ${DBPATH}
        # unpack (overwrite as needed)
        gunzip -f ${DBPATH}/${GZIPFILENAME}
        # and update the symlink
        cd ${DBPATH}
        rm -f ${LINKNAME}
        ln -s ${MMDBFILENAME} ${LINKNAME}
else
        echo "Downloaded file is not a valid gzip, bailing out!"
        exit 1
fi
