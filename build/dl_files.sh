#!/usr/bin/env bash

cd "$(dirname "$0")"

if [[ $(uname) == "Darwin" ]]; then
    dir="bin/macos/"
    if [[ $(uname -a) == "arm64" ]]; then
        dir+="arm64"
    fi
elif [[ $(uname) == "Linux" ]]; then
    dir="bin/linux/"
    if [[ $(uname -m) == "a"* && $(getconf LONG_BIT) == 64 ]]; then
        dir+="arm64"
    elif [[ $(uname -m) == "a"* ]]; then
        dir+="armhf"
    else
        dir+="x86_64"
    fi
fi
dl_files="$dir/dl_files"
partialzip="$dir/partialzip"

url="https://updates.cdn-apple.com/2019/ios/091-25277-20190722-0C1B94DE-992C-11E9-A2EE-E2C9A77C2E40/iPhone_4.0_32bit_10.3.4_14G61_Restore.ipsw"

mkdir image3 2>/dev/null
$partialzip $url 058-75249-065.dmg image3/rrdsk
$partialzip $url Firmware/dfu/iBEC.iphone5.RELEASE.dfu image3/iBoot.n42

$dl_files
mv image3/iBoot.n42 image3/iBoot.iphone5
