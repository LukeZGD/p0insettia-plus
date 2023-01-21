#!/bin/bash

cd "$(dirname "$0")"

dl_files="../build/dl_files.sh"
hfsplus="../build/hfsplus"
xpwntool="../build/xpwntool"
if [[ $(uname) == "Linux" ]]; then
    hfsplus+="_linux"
    xpwntool+="_linux"
fi

rm -rf image3/idsk

$dl_files
cp -R ../build/image3 .

$xpwntool image3/rrdsk image3/rrdsk.dmg

$hfsplus image3/rrdsk.dmg grow 40000000

$hfsplus image3/rrdsk.dmg untar src/binSB.tar

$hfsplus image3/rrdsk.dmg mv usr/local/bin/restored_external usr/local/bin/restored_external_
$hfsplus image3/rrdsk.dmg add src/n42/11d257/partition usr/local/bin/restored_external
$hfsplus image3/rrdsk.dmg chmod 755 usr/local/bin/restored_external
$hfsplus image3/rrdsk.dmg chown 0:0 usr/local/bin/restored_external

$hfsplus image3/rrdsk.dmg add src/n42/11d257/exploit.dmg exploit.dmg
$hfsplus image3/rrdsk.dmg chmod 644 exploit.dmg
$hfsplus image3/rrdsk.dmg chown 0:0 exploit.dmg

$xpwntool image3/rrdsk.dmg image3/idsk -t image3/rrdsk
rm -rf image3/rrdsk.dmg

echo "[*] done!"
echo "[*] n42 iBoot-1940.10.58 only!"
