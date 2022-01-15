#!/bin/sh
# CARP control script called by devd on CARP state change
# Calls /usr/local/etc/carpcontrol.d/ scripts
# Part of https://github.com/tykling/ansible-roles

logger -t carp "$(basename "$0") called for ${1} state ${2} - calling CARP hooks..."

DPATH=/usr/local/etc/carpcontrol.d
# do we have a carpcontrol.d dir for any vhid
if [ -d ${DPATH}/any ]; then
    # do we have a dir for any state
    if [ -d ${DPATH}/any/any ]; then
        # run any executables found
        find ${DPATH}/any/any -type f -perm +111 -exec {} "${1}" "${2}" \;
    fi
    # do we have a dir for the new state
    if [ -d ${DPATH}/any/"${2}" ]; then
        # run any executables found
        find ${DPATH}/any/"${2}" -type f -perm +111 -exec {} "${1}" "${2}" \;
    fi
fi

# do we have a carpcontrol.d dir for this vhid@ifname
if [ -d ${DPATH}/"${1}" ]; then
    # do we have a dir for any state
    if [ -d ${DPATH}/"${1}"/any ]; then
        # run any executables found
        find ${DPATH}/"${1}"/any -type f -perm +111 -exec {} "${1}" "${2}" \;
    fi
    # do we have a dir for the new state
    if [ -d ${DPATH}/"${1}"/"${2}" ]; then
        # run any executables found
        find ${DPATH}/"${1}"/"${2}" -type f -perm +111 -exec {} "${1}" "${2}" \;
    fi
fi

logger -t carp "$(basename "$0") done running CARP hooks"
