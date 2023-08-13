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

MODEL="$1"
rrdsk="058-4276-009.dmg"
mkdir -p fw/Firmware/all_flash/all_flash.${MODEL}ap.production fw/Firmware/dfu fw/Firmware/usr/local/standalone 2>/dev/null
latest_url="https://updates.cdn-apple.com/2019/ios/091-25277-20190722-0C1B94DE-992C-11E9-A2EE-E2C9A77C2E40/iPhone_4.0_32bit_10.3.4_14G61_Restore.ipsw"

case $MODEL in
    "n41" )
        restore_url="http://appldnld.apple.com/iOS7.1/031-4773.20140627.undN4/iPhone5,1_7.1.2_11D257_Restore.ipsw"
        device_model2="iphone5"
        url="$restore_url"
        case $2 in
            "11D201" ) url="http://appldnld.apple.com/iOS7.1/031-00091.20140425.AGVWW/iPhone5,1_7.1.1_11D201_Restore.ipsw";;
            "11D167" ) url="http://appldnld.apple.com/iOS7.1/031-4323.20140310.gdKZa/iPhone5,1_7.1_11D167_Restore.ipsw";;
        esac
    ;;
    "n42" )
        restore_url="http://appldnld.apple.com/iOS7.1/031-4798.20140627.fpeqS/iPhone5,2_7.1.2_11D257_Restore.ipsw"
        device_model2="iphone5"
        url="$restore_url"
        case $2 in
            "11D201" ) url="http://appldnld.apple.com/iOS7.1/031-00272.20140425.YvPzG/iPhone5,2_7.1.1_11D201_Restore.ipsw";;
            "11D167" ) url="http://appldnld.apple.com/iOS7.1/031-4537.20140310.4PCL5/iPhone5,2_7.1_11D167_Restore.ipsw";;
        esac
    ;;
    "n48" )
        restore_url="http://appldnld.apple.com/iOS7.1/031-4814.20140627.YoE3b/iPhone5,3_7.1.2_11D257_Restore.ipsw"
        device_model2="iphone5b"
        url="$restore_url"
        case $2 in
            "11D201" ) url="http://appldnld.apple.com/iOS7.1/031-00352.20140425.3ENrP/iPhone5,3_7.1.1_11D201_Restore.ipsw";;
            "11D167" ) url="http://appldnld.apple.com/iOS7.1/031-4631.20140310.6Gser/iPhone5,3_7.1_11D167_Restore.ipsw";;
        esac
    ;;
    "n49" )
        restore_url="http://appldnld.apple.com/iOS7.1/031-4772.20140627.75PIm/iPhone5,4_7.1.2_11D257_Restore.ipsw"
        device_model2="iphone5b"
        url="$restore_url"
        case $2 in
            "11D201" ) url="http://appldnld.apple.com/iOS7.1/031-00098.20140425.n3aEh/iPhone5,4_7.1.1_11D201_Restore.ipsw";;
            "11D167" ) url="http://appldnld.apple.com/iOS7.1/031-4322.20140310.kOVha/iPhone5,4_7.1_11D167_Restore.ipsw";;
        esac
    ;;
esac
if [[ -z $url ]]; then
    echo "[Error] No valid buildversion specified in argument."
    echo "* Specify the buildversion of your SHSH blob. (11D167, 11D201, or 11D257)"
    exit 1
fi

$partialzip $restore_url $rrdsk fw/$rrdsk
$partialzip $restore_url kernelcache.release.${MODEL} fw/kernelcache.release.${MODEL}
$partialzip $restore_url Firmware/dfu/iBEC.${MODEL}ap.RELEASE.dfu fw/Firmware/dfu/iBEC.${MODEL}ap.RELEASE.dfu
$partialzip $restore_url Firmware/dfu/iBSS.${MODEL}ap.RELEASE.dfu fw/Firmware/dfu/iBSS.${MODEL}ap.RELEASE.dfu
$partialzip $restore_url Firmware/all_flash/all_flash.${MODEL}ap.production/DeviceTree.${MODEL}ap.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/DeviceTree.${MODEL}ap.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/applelogo@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/applelogo@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/batterycharging0@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/batterycharging0@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/batterycharging1@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/batterycharging1@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/batteryfull@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/batteryfull@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/batterylow0@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/batterylow0@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/batterylow1@2x~iphone.s5l8950x.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/batterylow1@2x~iphone.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/glyphplugin@1136~iphone-lightning.s5l8950x.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/glyphplugin@1136~iphone-lightning.s5l8950x.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/iBoot.${MODEL}ap.RELEASE.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/iBoot.${MODEL}ap.RELEASE.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/LLB.${MODEL}ap.RELEASE.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/LLB.${MODEL}ap.RELEASE.img3
$partialzip $url Firmware/all_flash/all_flash.${MODEL}ap.production/recoverymode@1136~iphone-lightning.s5l8950x.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/recoverymode@1136~iphone-lightning.s5l8950x.img3

$partialzip $latest_url Firmware/all_flash/DeviceTree.${MODEL}ap.img3 fw/Firmware/all_flash/all_flash.${MODEL}ap.production/DeviceTreeX.${MODEL}ap.img3
$partialzip $latest_url Firmware/dfu/iBEC.${device_model2}.RELEASE.dfu fw/Firmware/all_flash/all_flash.${MODEL}ap.production/iBootX.n42ap.RELEASE.img3
$partialzip $restore_url BuildManifest.plist fw/BuildManifest.plist
$partialzip $restore_url Restore.plist fw/Restore.plist

$untether
