# p0insettia - untether
A tool for untethered jailbreak for iOS 10.3.4 iPhone 5 (iPhone5,2 Global only) with checkm8 BootROM exploit and iOS 7 iBoot exploit.

## Note
All at your own risk!  

## Supported environments
- macOS 10.13 (or later?) (intel/x86_64)
- Linux x86_64/armhf/arm64

## setup
```
./partitioning_gen.sh
```

## Usage 
- Your device must be jailbroken with p0insettia semi-tethered before installing this untether!

### Install old iboot and bootloader  
- gen custom fw  
```
./gen_fw_n42.sh <build version of blob> (example: ./gen_fw_n42.sh 11D257)
```
- restore nand_fw  
Place your iOS 7.1.x blob in the shsh folder with name: `<ECID>-iPhone5,2-7.1.2.shsh`  
Please set the device to **pwned DFU Mode** (use [iOS-OTA-Downgrader](https://github.com/LukeZGD/iOS-OTA-Downgrader) or [iPwnder Lite for iOS](https://github.com/LukeZGD/iOS-OTA-Downgrader/wiki/Pwning-Using-Another-iOS-Device)), connect it, and run the following script (change `11D257` to your build version if needed).
```
./restore_ipsw.sh
```
The device will reboot and enter recovery mode.  

### Install exploit and setup nvram  
Please set the device to **pwned DFU Mode**, connect it, and run the following script.  
```
./partitioning_boot.sh
```

## LICENSE
GPL-3.0  
