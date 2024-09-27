#!/bin/bash

cd "$(dirname "$0")"

if [[ $(uname) == "Darwin" ]]; then
    dir="bin/macos/"
    if [[ $(uname -a) == "arm64" ]]; then
        dir+="arm64"
    fi
    irecovery="$dir/irecovery"
elif [[ $(uname) == "Linux" ]]; then
    dir="bin/linux/"
    if [[ $(uname -m) == "a"* && $(getconf LONG_BIT) == 64 ]]; then
        dir+="arm64"
    elif [[ $(uname -m) == "a"* ]]; then
        dir+="armhf"
    else
        dir+="x86_64"
    fi
    irecovery="sudo $dir/irecovery"
fi

ProdCut=7 # cut 7 for ipod/ipad
device_type=$($irecovery -qv 2>&1 | grep "Connected to iP" | cut -c 14-)
if [[ $(echo "$device_type" | cut -c 3) == 'h' ]]; then
    ProdCut=9 # cut 9 for iphone
fi
device_type=$(echo "$device_type" | cut -c -$ProdCut)
case $device_type in
    iPhone5,[12] ) $irecovery -f image3/iBoot.iphone5;;
    iPhone5,[34] ) $irecovery -f image3/iBoot.iphone5b;;
esac
sleep 5

$irecovery -f image3/rdsk
$irecovery -c "ramdisk"
sleep 1

$irecovery -f ../iphoneos-arm/iboot/payload_rd
$irecovery -c "go"
