#! /bin/sh
# Extract IPv4 addresses from $1 ("-" for standard input) or $HOSTSFILE and
# output in a format suitable for "dnsd.conf".
#
# Version 2017.272
#
# Copyright (c) 2017 Guenther Brunthaler. All rights reserved.
#
# This source file is free software.
# Distribution is permitted under the terms of the GPLv3.

HOSTSFILE=/etc/hosts

set -e
trap 'test $? = 0 || echo "$0 failed!" >& 2' 0
case $1 in
	-) HOSTSFILE=;;
	'') ;;
	*) HOSTSFILE=$1
esac
if test -n "$HOSTSFILE"
then
	test -f "$HOSTSFILE"; exec < "$HOSTSFILE"
fi
c4='[0-9]\{1,3\}'
c6='[[:xdigit:]]\{1,2\}'
ip=
while read -r line
do
	set -- ${line%%#*}
	while test $# != 0
	do
		if expr x"$1" : x"$c4\(\.$c4\)\{3\}$" > /dev/null
		then
			ip=$1
		elif
			expr x"$1" : x"$c6\(:$c6\)\{15\}$" \
				'|' x"$1" : x"$c6*::$c6*$" \
				> /dev/null
		then
			ip=
		elif test "$1" && test "$ip"
		then
			printf '%s\n' "$1 $ip"
		fi
		shift
	done
done
