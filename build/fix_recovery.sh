#!/usr/bin/env bash

cd "$(dirname "$0")"

if [[ $(uname) == "Darwin" ]]; then
    dir="bin/macos/"
    if [[ $(uname -a) == "arm64" ]]; then
        dir+="arm64"
    fi
    irecovery="$dir/irecovery"
elif [[ $(uname) == "Linux" ]]; then
    dir="bin/linux/"
    if [[ $(uname -m) == "a"* && $(getconf LONG_BIT) == 64 ]]; then
        dir+="arm64"
    elif [[ $(uname -m) == "a"* ]]; then
        dir+="armhf"
    else
        dir+="x86_64"
    fi
    irecovery="sudo $dir/irecovery"
fi

$irecovery -n
