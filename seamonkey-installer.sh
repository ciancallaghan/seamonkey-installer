#!/bin/bash

if [[ $EUID != 0 ]]; then
		echo "Please run as root/sudo"
		exit
fi

pkgurl=`curl -s "https://www.seamonkey-project.org/releases/" | grep 'en-GB.linux-x86_64' | cut -d '"' -f 2`
pkgname=`echo $pkgurl | cut -d '/' -f 10 | cut -d '"' -f 1`

wget $pkgurl
tar -xf $pkgname -C /opt
cp ./seamonkey.desktop /usr/share/applications/seamonkey.desktop
ln -s /opt/seamonkey/seamonkey /usr/bin/seamonkey
rm $pkgname
