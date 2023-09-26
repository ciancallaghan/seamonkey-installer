#!/bin/sh

set -e

if [ "$(id -u)" != 0 ]; then
	printf "Must be run as sudo/root.\n"
	exit 1
fi

rm -r /opt/seamonkey
rm /usr/share/applications/seamonkey.desktop
rm /usr/bin/seamonkey
