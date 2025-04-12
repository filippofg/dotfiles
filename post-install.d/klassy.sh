#!/usr/bin/env bash

set -e
set -u
set -o pipefail

#if [ ! -e /etc/debian-version ]; then
#    echo "Not a Debian distro, skipping."
#    exit
#fi
#
#echo "Adding klassy repo..."
#echo 'deb http://download.opensuse.org/repositories/home:/paul4us/Debian_Testing/ /' | sudo tee /etc/apt/sources.list.d/home:paul4us.list > /dev/null
#curl -fsSL https://download.opensuse.org/repositories/home:paul4us/Debian_Testing/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_paul4us.gpg > /dev/null
#
#echo "Updating package index..."
#sudo apt update > /dev/null
#sudo apt install klassy -y
#
#echo "All done!"
