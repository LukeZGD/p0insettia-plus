#!/bin/bash

cd "$(dirname "$0")"

idevicerestore="bin/macos/idevicerestore"
irecovery="../build/bin/macos/irecovery"
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
    irecovery="sudo ../build/$dir/irecovery"
    device_ecid=$((16#$($irecovery -q | grep "ECID" | cut -c 9-))) # converts hex ecid to dec
    sudo systemctl stop usbmuxd
    sudo usbmuxd -pz
    usbmuxd_pid=$!
fi

if [[ -n $1 ]]; then
    echo "* ECID: $device_ecid"
    cp $1 shsh/$device_ecid-iPhone5,2-7.1.2.shsh
else
    echo "[Error] No SHSH file specified in argument."
    echo "* Specify the name of your SHSH file: ./restore_ipsw.sh my_712_blob.shsh"
    exit 1
fi
$idevicerestore -e -w restorenand_n42ap_11D257.ipsw

if [[ $(uname) == "Linux" ]]; then
    kill $usbmuxd_pid
    sudo systemctl restart usbmuxd
fi
