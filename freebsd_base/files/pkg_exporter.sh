#!/bin/sh
/usr/sbin/pkg update > /dev/null 2>&1

echo "# HELP pkg_build_info The version of pkg installed"
echo "# TYPE pkg_build_info gauge"
/bin/echo "pkg_build_info{version=\"$(/usr/sbin/pkg -v)\", abi=\"$(/usr/sbin/pkg config abi)\"} 1"

echo "# HELP pkg_packages_total Total number of pkg packages grouped by version as compared to index."
echo "# TYPE pkg_packages_total gauge"
/bin/echo "pkg_packages_total{version=\"equal\"} $(/usr/sbin/pkg version -ql \= | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"
/bin/echo "pkg_packages_total{version=\"older\"} $(/usr/sbin/pkg version -ql \< | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"
/bin/echo "pkg_packages_total{version=\"newer\"} $(/usr/sbin/pkg version -ql \> | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"

echo "# HELP pkg_vulnerable_packages_total Total number of vulnerable packages installed, as reported by 'pkg audit'."
echo "# TYPE pkg_vulnerable_packages_total gauge"
/bin/echo "pkg_vulnerable_packages_total $(/usr/sbin/pkg audit -q | /usr/bin/wc -l | /usr/bin/awk '{print $1}')"

echo "# HELP pkg_packages_freebsd_version_total Total number of installed packages labeled with the FreeBSD_version annotation."
echo "# TYPE pkg_packages_freebsd_version_total gauge"
for version in "$(/usr/sbin/pkg annotate --all --show FreeBSD_version | /usr/bin/cut -d " " -f 5 | /usr/bin/sort | /usr/bin/uniq -c | /usr/bin/awk '{print "pkg_packages_freebsd_version_total{freebsd_version=\x22" $2 "\x22} " $1}')"; do
        /bin/echo "$version";
done
