#!/bin/bash

cd "$(dirname "$0")"

untether="bin/macos/untether"
partialzip="../build/bin/macos/partialzip"
if [[ $(uname) == "Linux" ]]; then
    dir="bin/linux/"
    if [[ $(uname -m) == "a"* && $(getconf LONG_BIT) == 64 ]]; then
        dir+="arm64"
    elif [[ $(uname -m) == "a"* ]]; then
        dir+="armhf"
    else
        dir+="x86_64"
    fi
    untether="$dir/untether"
    partialzip="../build/$dir/partialzip"
fi

mkdir -p fw/Firmware/all_flash/all_flash.n42ap.production fw/Firmware/dfu fw/Firmware/usr/local/standalone 2>/dev/null
restore_url="https://secure-appldnld.apple.com/iOS7.1/031-4798.20140627.fpeqS/iPhone5,2_7.1.2_11D257_Restore.ipsw"
latest_url="https://updates.cdn-apple.com/2019/ios/091-25277-20190722-0C1B94DE-992C-11E9-A2EE-E2C9A77C2E40/iPhone_4.0_32bit_10.3.4_14G61_Restore.ipsw"

if [[ $1 == "11D257" ]]; then
    url="https://secure-appldnld.apple.com/iOS7.1/031-4798.20140627.fpeqS/iPhone5,2_7.1.2_11D257_Restore.ipsw"
elif [[ $1 == "11D201" ]]; then
    url="https://secure-appldnld.apple.com/iOS7.1/031-00272.20140425.YvPzG/iPhone5,2_7.1.1_11D201_Restore.ipsw"
elif [[ $1 == "11D167" ]]; then
    url="https://secure-appldnld.apple.com/iOS7.1/031-4537.20140310.4PCL5/iPhone5,2_7.1_11D167_Restore.ipsw"
else
    echo "[Error] No valid buildversion specified in argument."
    echo "* Specify the buildversion of your SHSH blob. (11D167, 11D201, or 11D257)"
    exit 1
fi

$partialzip $restore_url 058-4276-009.dmg fw/058-4276-009.dmg
$partialzip $restore_url kernelcache.release.n42 fw/kernelcache.release.n42
$partialzip $restore_url Firmware/dfu/iBEC.n42ap.RELEASE.dfu fw/Firmware/dfu/iBEC.n42ap.RELEASE.dfu
$partialzip $restore_url Firmware/dfu/iBSS.n42ap.RELEASE.dfu fw/Firmware/dfu/iBSS.n42ap.RELEASE.dfu
$partialzip $restore_url Firmware/all_flash/all_flash.n42ap.production/DeviceTree.n42ap.img3 fw/Firmware/all_flash/all_flash.n42ap.production/DeviceTree.n42ap.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/applelogo@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.n42ap.production/applelogo@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/batterycharging0@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.n42ap.production/batterycharging0@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/batterycharging1@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.n42ap.production/batterycharging1@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/batteryfull@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.n42ap.production/batteryfull@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/batterylow0@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.n42ap.production/batterylow0@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/batterylow1@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.n42ap.production/batterylow1@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/glyphplugin@1136~iphone-lightning.s5l8950x.img3 fw/Firmware/all_flash/all_flash.n42ap.production/glyphplugin@1136~iphone-lightning.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/iBoot.n42ap.RELEASE.img3 fw/Firmware/all_flash/all_flash.n42ap.production/iBoot.n42ap.RELEASE.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/LLB.n42ap.RELEASE.img3 fw/Firmware/all_flash/all_flash.n42ap.production/LLB.n42ap.RELEASE.img3
$partialzip $url Firmware/all_flash/all_flash.n42ap.production/recoverymode@1136~iphone-lightning.s5l8950x.img3 fw/Firmware/all_flash/all_flash.n42ap.production/recoverymode@1136~iphone-lightning.s5l8950x.img3

$partialzip $latest_url Firmware/all_flash/DeviceTree.n42ap.img3 fw/Firmware/all_flash/all_flash.n42ap.production/DeviceTreeX.n42ap.img3
$partialzip $latest_url Firmware/dfu/iBEC.iphone5.RELEASE.dfu fw/Firmware/all_flash/all_flash.n42ap.production/iBootX.n42ap.RELEASE.img3
$partialzip $restore_url BuildManifest.plist fw/BuildManifest.plist
$partialzip $restore_url Restore.plist fw/Restore.plist

$untether
