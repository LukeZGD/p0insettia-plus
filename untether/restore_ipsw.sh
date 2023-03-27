#!/bin/bash

cd "$(dirname "$0")"

idevicerestore="bin/macos/idevicerestore"
if [[ $(uname) == "Linux" ]]; then
    dir="bin/linux/"
    if [[ $(uname -m) == "a"* && $(getconf LONG_BIT) == 64 ]]; then
        dir+="arm64"
    elif [[ $(uname -m) == "a"* ]]; then
        dir+="armhf"
    else
        dir+="x86_64"
    fi
    idevicerestore="sudo $dir/idevicerestore"
fi

sudo systemctl stop usbmuxd
sudo usbmuxd -pz
usbmuxd_pid=$!
$idevicerestore -e -w restorenand_n42ap_11D257.ipsw
kill $usbmuxd_pid
sudo systemctl restart usbmuxd
