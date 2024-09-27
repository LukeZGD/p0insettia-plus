#!/bin/bash

cd "$(dirname "$0")"

dl_files="../build/dl_files.sh"
if [[ $(uname) == "Darwin" && $(uname -a) == "arm64" ]]; then
    platform_arch="/arm64"
fi
hfsplus="../build/bin/macos$platform_arch/hfsplus"
xpwntool="../build/bin/macos$platform_arch/xpwntool"
if [[ $(uname) == "Linux" ]]; then
    dir="bin/linux/"
    if [[ $(uname -m) == "a"* && $(getconf LONG_BIT) == 64 ]]; then
        dir+="arm64"
    elif [[ $(uname -m) == "a"* ]]; then
        dir+="armhf"
    else
        dir+="x86_64"
    fi
    hfsplus="../build/$dir/hfsplus"
    xpwntool="../build/$dir/xpwntool"
fi

device_model="iphone5"
rm -rf image3/idsk

$dl_files
cp -R ../build/image3 .

$xpwntool image3/rrdsk image3/rrdsk.dmg

$hfsplus image3/rrdsk.dmg grow 40000000

$hfsplus image3/rrdsk.dmg untar src/binSB.tar

$hfsplus image3/rrdsk.dmg mv usr/local/bin/restored_external usr/local/bin/restored_external_
$hfsplus image3/rrdsk.dmg add src/$device_model/11D257/partition usr/local/bin/restored_external
$hfsplus image3/rrdsk.dmg chmod 755 usr/local/bin/restored_external
$hfsplus image3/rrdsk.dmg chown 0:0 usr/local/bin/restored_external

$hfsplus image3/rrdsk.dmg add src/$device_model/11D257/exploit.dmg exploit.dmg
$hfsplus image3/rrdsk.dmg chmod 644 exploit.dmg
$hfsplus image3/rrdsk.dmg chown 0:0 exploit.dmg

$xpwntool image3/rrdsk.dmg image3/idsk -t image3/rrdsk
rm -rf image3/rrdsk.dmg

echo "[*] done!"
