#!/bin/bash

cd "$(dirname "$0")"

echo "Run it only once!"
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
    irecovery="sudo ../build/$dir/irecovery"
fi

$irecovery -f image3/iBoot.n42
sleep 5

$irecovery -f image3/idsk
$irecovery -c "ramdisk"
sleep 1

$irecovery -f ../iphoneos-arm/iboot/payload_rd
$irecovery -c "go"
