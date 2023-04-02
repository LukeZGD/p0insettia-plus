# p0insettia plus
- p0insettia plus is a fork of p0insettia, an iOS 10.3.4 jailbreak for iPhone 5 devices with checkm8 BootROM exploit.
- p0insettia can be used as semi-tethered, semi-untethered, or fully untethered jailbreak.
- This fork has updated scripts, Linux builds, and compiled payloads.
- This fork installs Zebra instead of Cydia. (based on [socket jailbreak](https://github.com/staturnzz/socket))
- Only tested semi-tether and untether on iPhone5,2 10.3.4 with 7.1.1 (11D201) blobs.
- [Download](https://github.com/LukeZGD/p0insettia/archive/refs/heads/main.zip)

## Note
- All at your own risk!  

## Supported devices
- iPhone 5 (N41/N42) - iOS 10.3.4  
- Untethered jailbreak supports N42 only

## Supported environments
- macOS 10.13 (or later?) (intel/x86_64)
- Linux x86_64/armhf/arm64

## Semi-tethered jailbreak
- Please refer to the build/ directory.  

## Semi-untethered jailbreak
- It uses an IPA App based jailbreak. (reloader/ directory)   
- In order to use this, you need to jailbreak your device with "semi-tethered jailbreak" first.  
- The pre-built IPA file can be obtained in reloader/ directory.  
- You can use Sideloadly, ReProvision Reborn, or similar to install and use IPA files on your device. All at your own risk.   

## Untethered jailbreak
- It uses an iBoot (iOS 7 iBoot) exploit based jailbreak. (untether/ directory)   
- In order to use this, you need to jailbreak your device with "semi-tethered jailbreak" first.  

## Note for this jailbreak environment (iOS 10.3 or higher)  
- This jailbreak will not destroy sandbox containers.  
- In iOS 10.3 and later, apps under /Applications will also be sandboxed. so, Apps such as Cydia will be sandboxed and will not work.  
- You can use [container-resign](https://github.com/staturnzz/socket#information) from Socket Repo to resign apps.  
- Key `com.apple.private.security.no-container`  
- Some other jailbreak apps may require this entitlement.
- Entitlement key
```
<key>com.apple.private.security.no-container</key>
<true/>
```

## Credits
- axi0mX for the [checkm8 exploit](https://github.com/axi0mX/ipwndfu)  
- Linus Henze for [Fugu](https://github.com/LinusHenze/Fugu)  
- planetbeing for [XPwn](https://github.com/planetbeing/xpwn) and [ios-jailbreak-patchfinder](https://github.com/planetbeing/ios-jailbreak-patchfinder)  
- xerub for [ibex](https://github.com/xerub/ibex)  
- libimobiledevice for [libirecovery](https://github.com/libimobiledevice/libirecovery)  
- synackuk for [atropine](https://github.com/synackuk/atropine)  
- checkra1n team for the kernel patch method  
- staturnz for [socket](https://github.com/staturnzz/socket)
