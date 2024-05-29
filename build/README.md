# p0insettia semi-tether
A tool for semi-tethered jailbreak for iOS 10.3.4 iPhone 5 with checkm8 BootROM exploit.

## Note
All at your own risk!  

## Supported environments
- macOS 10.13 or later
- Linux x86_64/armhf/arm64

## Setup
```
./dl_files.sh
./ramdisk_gen.sh
```

## Usage 
### Install Loader / Zebra  
The first step is to add the loader app to the rootfs of the device.  
Please set the device to **pwned DFU Mode**. Use [Legacy iOS Kit](https://github.com/LukeZGD/Legacy-iOS-Kit) (Other Utilities -> Send Pwned iBSS) or [iPwnder Lite for iOS](https://github.com/LukeZGD/Legacy-iOS-Kit/wiki/Pwning-Using-Another-iOS-Device). Then run the following script.
```
./ramdisk_boot.sh
```

The device will reboot and enter recovery mode.  
Please set the device to **pwned DFU Mode** and run the following script.
```
./tethered_boot.sh
```

The device will show the loader app.  
![](../image/1.png)

Please open it and tap "Install Cydia".  
![](../image/2.png) ![](../image/3.png)

The device will reboot and enter recovery mode.  

### Reboot and setup Zebra
Perform the initial startup. Please set the device to **pwned DFU Mode** and run the following script.
```
./tethered_boot.sh
```

- Zebra should appear on the home screen after waiting for a few minutes.

### Fix recovery mode
Now, when you try to reboot your device, it will boot in recovery mode. Connect the device in recovery mode to USB and run the following script.  
```
./fix_recovery.sh
```

The device will reboot and boot in non-jailbreak mode. If you want to boot in a jailbreak environment again, set the device to **pwned DFU mode** and run the following script.
```
./tethered_boot.sh
```

## LICENSE
hfsplus & xpwntool: GPL-3.0 [original](https://github.com/planetbeing/xpwn)  
irecovery: LGPL-v2.1 [original](https://github.com/libimobiledevice/libirecovery)  
