#!/usr/local/bin/bash
# CARP control script called by devd on CARP state change
# Calls /usr/local/etc/carpcontrol.d/ scripts
# Part of https://github.com/tykling/ansible-roles

logger -t carp "${basename $0} called for ${1} state ${2} - calling CARP hooks..."

PATH=/usr/local/etc/carpcontrol.d/
# do we have a carpcontrol.d dir for any vhid
if [ -d ${PATH}/any ]; then
    # do we have a dir for any state
    if [ -d ${PATH}/any/any ]; then
        # run any executables found
        find -type f -perm +111 ${PATH}/any/any -exec {} ${1} ${2 } \;
    fi
    # do we have a dir for the new state
    if [ -d ${PATH}/any/${2} ]; then
        # run any executables found
        find -type f -perm +111 ${PATH}/any/${2} -exec {} ${1} ${2 } \;
    fi
fi

# do we have a carpcontrol.d dir for this vhid@ifname
if [ -d ${PATH}/${1} ]; then
    # do we have a dir for any state
    if [ -d ${PATH}/${1}/any ]; then
        # run any executables found
        find -type f -perm +111 ${PATH}/${1}/any -exec {} ${1} ${2 } \;
    fi
    # do we have a dir for the new state
    if [ -d ${PATH}/${1}/${2} ]; then
        # run any executables found
        find -type f -perm +111 ${PATH}/${1}/${2} -exec {} ${1} ${2 } \;
    fi
fi

logger -t carp "${basename $0} done running CARP hooks"
