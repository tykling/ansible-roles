#!/bin/sh
/usr/sbin/pkg update
/bin/echo "pkg_info{version=\"$(pkg -v)\", abi=\"$(/usr/sbin/pkg config abi)\"} 1"
/bin/echo "pkg_packages_total{version=\"equal\"} $(/usr/sbin/pkg version -l \= | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"
/bin/echo "pkg_packages_total{version=\"older\"} $(/usr/sbin/pkg version -l \< | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"
/bin/echo "pkg_packages_total{version=\"newer\"} $(/usr/sbin/pkg version -l \> | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"
/bin/echo "pkg_vulnerable_packages_total{version=\"vulnerable\"} $(/usr/sbin/pkg audit -q | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"

