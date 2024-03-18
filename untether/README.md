# p0insettia untether
A tool for untethered jailbreak for iOS 10.3.4 iPhone 5/5C with checkm8 BootROM exploit and iOS 7 iBoot exploit.

## Note
All at your own risk!  

## Supported environments
- macOS 10.13 (or later?) (intel/x86_64)
- Linux x86_64/armhf/arm64

## setup
- change `<device type>` with `iphone5` for iPhone 5, `iphone5b` for iPhone 5C
```
./partitioning_gen.sh <device type>
```

## Usage 
- Your device must be jailbroken with p0insettia semi-tethered before installing this untether!
- iOS 7.1.x SHSH blobs for your device are required to install this!

### Install old iboot and bootloader
- gen custom fw
- change `<device model>` to device's model (`n41` for iPhone5,1, `n42` for iPhone5,2, `n48` for iPhone5,3, `n49` for iPhone5,4)
- change `<buildversion of shsh>`
```
./gen_fw.sh <device model> <buildversion of shsh> (example: ./gen_fw.sh n42 11D201)
```
- restore nand_fw  
Please set the device to **pwned DFU Mode**. Use [Legacy iOS Kit](https://github.com/LukeZGD/Legacy-iOS-Kit) (Other Utilities -> Send Pwned iBSS) or [iPwnder Lite for iOS](https://github.com/LukeZGD/Legacy-iOS-Kit/wiki/Pwning-Using-Another-iOS-Device)) Then run the following script (change `<shsh file>` to your SHSH blob file).
```
./restore_ipsw.sh <shsh file> (example: ./restore_ipsw.sh myblob.shsh)
```
The device will reboot and enter recovery mode.  

### Install exploit and setup nvram  
Please set the device to **pwned DFU Mode** and run the following script.
```
./partitioning_boot.sh
```

## LICENSE
GPL-3.0  
