#!/bin/sh
/usr/sbin/pkg update > /dev/null 2>&1

echo "# HELP pkg_build_info The version of pkg installed"
echo "# TYPE pkg_build_info gauge"
/bin/echo "pkg_build_info{version=\"$(/usr/sbin/pkg -v)\", abi=\"$(/usr/sbin/pkg config abi)\"} 1"

echo "# HELP pkg_packages_total Total number of pkg packages grouped by version as compared to index."
echo "# TYPE pkg_packages_total gauge"
/bin/echo "pkg_packages_total{version=\"equal\"} $(/usr/sbin/pkg version -l \= | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"
/bin/echo "pkg_packages_total{version=\"older\"} $(/usr/sbin/pkg version -l \< | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"
/bin/echo "pkg_packages_total{version=\"newer\"} $(/usr/sbin/pkg version -l \> | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"

echo "# HELP pkg_vulnerable_packages_total Total number of vulnerable packages installed, as reported by 'pkg audit'."
echo "# TYPE pkg_vulnerable_packages_total gauge"
/bin/echo "pkg_vulnerable_packages_total{version=\"vulnerable\"} $(/usr/sbin/pkg audit -q | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"

