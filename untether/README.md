# p0insettia - untether
A tool for untethered jailbreak of iOS 10.3.4 ~~32-bit devices~~ iPhone 5 with checkm8 BootROM exploit.

## Note
All at your own risk!  

## Supported environments
- macOS 10.13 (or later?) (intel/x86_64)
- Linux x86_64

## setup
```
./partitioning_gen.sh
```

## Usage 
### Install old iboot and bootloader  
- gen custom fw  
```
./gen_fw_n42.sh <buildversion (example: 11D257)>
```
- restore nand_fw  
Place your iOS 7.1.x blob in the shsh folder with name: `<ECID>-iPhone5,2-7.1.2.shsh`  
Please set the device to pwned DFU Mode, connect it, and run the following script.
```
./idevicerestore -e -w restorenand.ipsw # for mac
./idevicerestore_linux -e -w restorenand.ipsw # for linux
```
The device will reboot and enter recovery mode.  

### Install exploit and setup nvram  
Please set the device to pwned DFU Mode, connect it, and run the following script.  
```
./partitioning_boot.sh
```

## LICENSE
GPL-3.0  
