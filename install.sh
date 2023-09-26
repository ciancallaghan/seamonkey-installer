#!/bin/sh

set -e

if [ "$(id -u)" != 0 ]; then
	echo "Must be run as sudo/root."
	exit 1
fi

if ! hash curl ; then
	echo "Curl is required. Please install it."
	exit 1
elif ! hash wget; then
	echo "Wget is required. Please install it."
	exit 1
elif ! hash tar; then
	echo "Tar is required. Please install it."
	exit 1
fi

pkgs=$(curl -s "https://www.seamonkey-project.org/releases/" | grep "linux-x86_64")
langs=$(echo "$pkgs" | cut -d '"' -f 2 | cut -d "/" -f 9 | sort)
if [ -z "$langs" ]; then
	echo "No packages found. This could be an error with the URL."
	exit 1
fi

while true; do
	echo "$langs" "Choose language: "
	read -r lang
	lang=$(echo "$langs" | grep -i "$lang" | head -n 1)
	if [ -z "$lang" ]; then
		echo "Invalid language."
	fi
	echo "Is \"$lang\" correct? [y/n]"
	read -r yorn
	if [ "$yorn" = "y" ]; then
		break
	fi
done

pkgurl=$(echo "$pkgs" | grep "$lang" | cut -d '"' -f 2)
pkgname=$(echo "$pkgurl" | cut -d "/" -f 10)

wget "$pkgurl"
tar -xf "$pkgname" -C /opt
cp ./seamonkey.desktop /usr/share/applications/seamonkey.desktop
ln -s /opt/seamonkey/seamonkey /usr/bin/seamonkey
rm "$pkgname"
