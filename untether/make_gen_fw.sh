#!/bin/bash

rm gen_fw

cd ../Injector
clang untether.c -o gen_fw -I./include -DN42 -DHAVE_IBOOT_EXPLOIT

mv gen_fw untether
