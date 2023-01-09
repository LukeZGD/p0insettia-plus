#!/bin/bash

cd "$(dirname "$0")"

irecovery="./irecovery"
if [[ $(uname) == "Linux" ]]; then
    irecovery+="_linux"
fi

$irecovery -f image3/iBoot.n42
sleep 5

$irecovery -f image3/rdsk
$irecovery -c "ramdisk"
sleep 1

$irecovery -f ../iphoneos-arm/iboot/payload_rd
$irecovery -c "go"
