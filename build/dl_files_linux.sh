#!/bin/bash

cd "$(dirname $0)"

dl_files="./dl_files_linux"
partialzip="./partialzip_linux"
url="https://updates.cdn-apple.com/2019/ios/091-25277-20190722-0C1B94DE-992C-11E9-A2EE-E2C9A77C2E40/iPhone_4.0_32bit_10.3.4_14G61_Restore.ipsw"

mkdir image3 2>/dev/null
$partialzip $url 058-75249-065.dmg image3/rrdsk
$partialzip $url Firmware/dfu/iBEC.iphone5.RELEASE.dfu image3/iBoot.n42

$dl_files
