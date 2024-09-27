#!/bin/bash
#set -ex

clean() {
    rm -rf "$(dirname "$0")/restorenand"*/ 2>/dev/null
}

clean_sudo() {
    sudo rm -rf "$(dirname "$0")/restorenand"*/
}

clean_usbmuxd() {
    clean_sudo
    sudo killall usbmuxd 2>/dev/null
    if [[ $(which systemctl 2>/dev/null) ]]; then
        sleep 1
        sudo systemctl restart usbmuxd
    fi
}

cd "$(dirname "$0")"
trap "clean" EXIT
trap "exit 1" INT TERM

if [[ $(uname) == "Darwin" && $(uname -a) == "arm64" ]]; then
    platform_arch="/arm64"
fi
idevicerestore="bin/macos$platform_arch/idevicerestore"
irecovery="../build/bin/macos$platform_arch/irecovery"
if [[ $(uname) == "Linux" ]]; then
    dir="bin/linux/"
    if [[ $(uname -m) == "a"* && $(getconf LONG_BIT) == 64 ]]; then
        dir+="arm64"
    elif [[ $(uname -m) == "a"* ]]; then
        dir+="armhf"
    else
        dir+="x86_64"
    fi
    idevicerestore="sudo $dir/idevicerestore"
    irecovery="sudo ../build/$dir/irecovery"
    if [[ $(which systemctl 2>/dev/null) ]]; then
        sudo systemctl stop usbmuxd
    fi
    sudo -b usbmuxd -pf 2>/dev/null
    trap "clean_usbmuxd" EXIT
fi

if [[ ! -s $1 ]]; then
    echo "[Error] No SHSH file specified in argument."
    echo "* Specify the name of your SHSH file: ./restore_ipsw.sh my_7.1.x_blob.shsh"
    exit 1
fi

ProdCut=7 # cut 7 for ipod/ipad
device_type=$($irecovery -qv 2>&1 | grep "Connected to iP" | cut -c 14-)
if [[ $(echo "$device_type" | cut -c 3) == 'h' ]]; then
    ProdCut=9 # cut 9 for iphone
fi
device_type=$(echo "$device_type" | cut -c -$ProdCut)
case $device_type in
    iPhone5,1 ) device_model="n41";;
    iPhone5,2 ) device_model="n42";;
    iPhone5,3 ) device_model="n48";;
    iPhone5,4 ) device_model="n49";;
esac
if [[ -z $device_model ]]; then
    echo "[Error] Device not found or detected. Plug in your device in pwned DFU mode and try again."
    exit 1
fi
device_ecid=$(printf "%d" $($irecovery -q | grep "ECID" | cut -c 7-)) # converts hex ecid to dec

echo "* Device: $device_type (${device_model}ap)"
echo "* ECID: $device_ecid"
cp $1 shsh/$device_ecid-$device_type-7.1.2.shsh
ipsw="restorenand_${device_model}_11D257"
mkdir $ipsw
unzip -o "$ipsw.ipsw" -d "$ipsw/"
$idevicerestore -ew $ipsw.ipsw
