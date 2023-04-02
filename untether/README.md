# p0insettia untether
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
- iOS 7.1.x SHSH blobs for your device are required to install this!

### Install old iboot and bootloader  
- gen custom fw (change `<buildversion of shsh`)  
```
./gen_fw_n42.sh <buildversion of shsh> (example: ./gen_fw_n42.sh 11D257)
```
- restore nand_fw  
Please set the device to **pwned DFU Mode** (use [Legacy iOS Kit](https://github.com/LukeZGD/Legacy-iOS-Kit) or [iPwnder Lite for iOS](https://github.com/LukeZGD/Legacy-iOS-Kit/wiki/Pwning-Using-Another-iOS-Device)), connect it, and run the following script (change `<shsh file>` to your SHSH blob file).
```
./restore_ipsw.sh <shsh file> (example: ./restore_ipsw.sh myblob.shsh)
```
The device will reboot and enter recovery mode.  

### Install exploit and setup nvram  
Please set the device to **pwned DFU Mode**, connect it, and run the following script.  
```
./partitioning_boot.sh
```

## LICENSE
GPL-3.0  
