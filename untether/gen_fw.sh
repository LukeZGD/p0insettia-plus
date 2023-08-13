#!/bin/bash

cd "$(dirname "$0")"

bspatch="$(which bspatch 2>/dev/null)"
hfsplus="../build/bin/macos/hfsplus"
partialzip="../build/bin/macos/partialzip"
untether="bin/macos/untether"
xpwntool="../build/bin/macos/xpwntool"
if [[ $(uname) == "Linux" ]]; then
    dir="bin/linux/"
    if [[ $(uname -m) == "a"* && $(getconf LONG_BIT) == 64 ]]; then
        dir+="arm64"
    elif [[ $(uname -m) == "a"* ]]; then
        dir+="armhf"
    else
        dir+="x86_64"
    fi
    bspatch="$dir/bspatch"
    hfsplus="../build/$dir/hfsplus"
    partialzip="../build/$dir/partialzip"
    untether="$dir/untether"
    xpwntool="../build/$dir/xpwntool"
fi

RAMDISK="058-4276-009.dmg"
VERSION="11D257"
MODEL="$1"
case $MODEL in
    n41 )
        RDSK_IV="ff1c66597ec26f715b65e4bb683839e3"
        RDSK_KEY="3b514e1c94e0169b1bb24f805595a4f8c0999d49eae207c34b2516ed30525a47"
        IBSS_IV="8a91e75a2a9130d005e8a38cb1d25c7d"
        IBSS_KEY="22e445c624c35a7b06fef7251c544693ba928557e5fda4e1020a67c42f0485c9"
        IBEC_IV="29dcc7e2846227b6e0ed4706e5aa1aec"
        IBEC_KEY="444815500fbedbf068a089cd7799831d28771d11dd3513a9b5ccdd1faed9d5a3"
        OS="058-4435-009.dmg"
        TYPE="iPhone5,1"
    ;;
    n42 )
        RDSK_IV="13b6456bec67fa74faada14e1c3607aa"
        RDSK_KEY="4e0bcc542aefc750cd463f6d0ed4710f15fb0ec0d2a11d4e213b6f58c1e20e87"
        IBSS_IV="d279e5c309be7ac035fd313958a178be"
        IBSS_KEY="617f7e2d5d8e2940a325758cd42055b83e2e3d243f068d5a9015b0fe67bed815"
        IBEC_IV="1d45b6ca42dafd5d711e3d23e5fa0fc7"
        IBEC_KEY="459912ddeeeb9d4a1c66068c8c1d8f46d8dd72e3e7dfa3ff0326f1ab6bb59c28"
        OS="058-4447-009.dmg"
        TYPE="iPhone5,2"
    ;;
    n48 )
        RDSK_IV="b2c9a993e0c2e5905993d95751d7e593"
        RDSK_KEY="47c69d148b1b091084c17044f605a7757e3a8fe03c87f5a632faa9ade0cb330f"
        IBSS_IV="7456fc0204f434d7f2a56385668f85aa"
        IBSS_KEY="c32c235edc8d29436d3c5a5f6d0607b97c70af3e2c68a7cbef0e60115baae06e"
        IBEC_IV="91302d8a02ba87a006633a8b11eb1f8d"
        IBEC_KEY="456ed22121c84c411d44bbb689f925b906019491cc2529150eaef0da9c59dbc3"
        OS="058-4139-009.dmg"
        TYPE="iPhone5,3"
    ;;
    n49 )
        RDSK_IV="3a1989089cc1e657a640c323f320dc79"
        RDSK_KEY="8c5dda7a01517ec83e78544578629bf5f41d9143ea813e40f16aea4014fbeb8f"
        IBSS_IV="8c86c49bb07c5c98db2d442a9fd02185"
        IBSS_KEY="3c719369bd5d996ee5eb8131142c4993f3b740e0623d49c29215371adeecbded"
        IBEC_IV="d6be0d2b198816e7b1756f8e8f702ac9"
        IBEC_KEY="749abcc93c2da56ca50deae5abd39cc91b069862741b9452aa173ecd7681512e"
        OS="058-4366-009.dmg"
        TYPE="iPhone5,4"
    ;;
esac
if [[ -z $TYPE ]]; then
    echo "[Error] Invalid argument. Valid arguments:"
    echo "    n41   - iPhone5,1"
    echo "    n42   - iPhone5,2"
    echo "    n48   - iPhone5,3"
    echo "    n49   - iPhone5,4"
    exit 1
fi
FWBUNDLE="${TYPE}_11D257.bundle"
OPTIONNAME="options."$MODEL".plist"
IBSS="iBSS."$MODEL"ap.RELEASE"
IBEC="iBEC."$MODEL"ap.RELEASE"

# config end

rm -rf fw/

./untether.sh "$1" "$2"
[[ $? != 0 ]] && exit 1

$xpwntool fw/"$RAMDISK" fw/ramdisk.dmg -iv $RDSK_IV -k $RDSK_KEY
$hfsplus fw/ramdisk.dmg grow 12000000

$hfsplus fw/ramdisk.dmg extract usr/sbin/asr asr
$bspatch asr asr_p injection/firmware/"$FWBUNDLE"/asr.patch
$hfsplus fw/ramdisk.dmg mv usr/sbin/asr usr/sbin/asr_
$hfsplus fw/ramdisk.dmg add asr_p usr/sbin/asr
$hfsplus fw/ramdisk.dmg chmod 755 usr/sbin/asr
$hfsplus fw/ramdisk.dmg chown 0:0 usr/sbin/asr

$hfsplus fw/ramdisk.dmg extract usr/local/bin/restored_external restored_external
$bspatch restored_external restored_external_p injection/firmware/"$FWBUNDLE"/restored_external.patch
$hfsplus fw/ramdisk.dmg mv usr/local/bin/restored_external usr/local/bin/restored_external_
$hfsplus fw/ramdisk.dmg add restored_external_p usr/local/bin/restored_external
$hfsplus fw/ramdisk.dmg chmod 755 usr/local/bin/restored_external
$hfsplus fw/ramdisk.dmg chown 0:0 usr/local/bin/restored_external

$hfsplus fw/ramdisk.dmg mv usr/local/share/restore/"$OPTIONNAME" usr/local/share/restore/"$OPTIONNAME"_
$hfsplus fw/ramdisk.dmg add injection/options.plist usr/local/share/restore/"$OPTIONNAME"
$hfsplus fw/ramdisk.dmg chmod 644 usr/local/share/restore/"$OPTIONNAME"
$hfsplus fw/ramdisk.dmg chown 0:0 usr/local/share/restore/"$OPTIONNAME"

mv fw/"$RAMDISK" fw/tmp.dmg
$xpwntool fw/ramdisk.dmg fw/"$RAMDISK" -t fw/tmp.dmg

# ibss
$xpwntool fw/Firmware/dfu/"$IBSS".dfu fw/Firmware/dfu/"$IBSS".dec -iv $IBSS_IV -k $IBSS_KEY
$bspatch fw/Firmware/dfu/"$IBSS".dec fw/Firmware/dfu/"$IBSS".pwnd injection/firmware/"$FWBUNDLE"/iBSS.patch
mv fw/Firmware/dfu/"$IBSS".dfu fw/Firmware/dfu/"$IBSS"_TMP.dfu
$xpwntool fw/Firmware/dfu/"$IBSS".pwnd fw/Firmware/dfu/"$IBSS".dfu -t fw/Firmware/dfu/"$IBSS"_TMP.dfu

# ibec
$xpwntool fw/Firmware/dfu/"$IBEC".dfu fw/Firmware/dfu/"$IBEC".dec -iv $IBEC_IV -k $IBEC_KEY
$bspatch fw/Firmware/dfu/"$IBEC".dec fw/Firmware/dfu/"$IBEC".pwnd injection/firmware/"$FWBUNDLE"/iBEC.patch
mv fw/Firmware/dfu/"$IBEC".dfu fw/Firmware/dfu/"$IBEC"_TMP.dfu
$xpwntool fw/Firmware/dfu/"$IBEC".pwnd fw/Firmware/dfu/"$IBEC".dfu -t fw/Firmware/dfu/"$IBEC"_TMP.dfu

# pyld 
$xpwntool ../iphoneos-arm/iboot/payload_untether fw/Firmware/all_flash/all_flash."$MODEL"ap.production/applelogoP@2x~iphone.s5l8950x.img3 -t src/pyld_template.img3

# m
cp -a -v injection/firmware/"$FWBUNDLE"/manifest fw/Firmware/all_flash/all_flash."$MODEL"ap.production/

# os
touch fw/"$OS"

rm -rf asr
rm -rf asr_p
rm -rf restored_external
rm -rf restored_external_p
rm -rf fw/tmp.dmg
rm -rf fw/ramdisk.dmg
rm -rf fw/Firmware/dfu/"$IBSS".pwnd
rm -rf fw/Firmware/dfu/"$IBSS".dec
rm -rf fw/Firmware/dfu/"$IBSS"_TMP.dfu
rm -rf fw/Firmware/dfu/"$IBEC".pwnd
rm -rf fw/Firmware/dfu/"$IBEC".dec
rm -rf fw/Firmware/dfu/"$IBEC"_TMP.dfu

cd fw

zip -r0 ../restorenand_"$MODEL"_"$VERSION".ipsw *

cd ..

rm -rf fw
