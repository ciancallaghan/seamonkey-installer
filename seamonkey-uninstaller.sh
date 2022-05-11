#!/bin/bash

if [[ $EUID != 0 ]]; then
		echo "Please run as root"
		exit
fi

rm -r /opt/seamonkey
rm /usr/share/applications/seamonkey.desktop
rm /usr/bin/seamonkey
