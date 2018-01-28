# SnapOS
Snapcast OS is planned to be a [Buildroot](https://buildroot.org) based embedded [Linux](https://www.kernel.org) OS for [Snapcast](https://github.com/badaix/snapcast).
There will be configurations for some boards, e.g. the Raspberry Pi 3 with WiFi and audio enabled, as well as packages for Snapcast and its dependencies.
What's currently missing is the port of Snapcast's build system from make to CMake, which will happen soon, as there are already two PRs that need to be merged.

## How-to
 1. Download or clone [Buildroot](https://buildroot.org) 
 2. Clone snapos to some directory
 3. Navigate into Buildroot's root directory and define snapos as an external:
```
buildroot-2017.11.2 $ make BR2_EXTERNAL=/PATH/TO/snapos/buildroot-external/ snapos_rpi3_defconfig
```
 4. Now you will find the pre-selected `Snapcast` package under `External options  --->` in `make menuconfig`
 5. Run `make`, wait, and find the image in `output/image/sdcard.img`
 6. Write the image to an sd card, e.g. (with `sdX` = your sd card's device name):
 ```
 buildroot-2017.11.2 $ sudo dd bs=4M if=output/images/sdcard.img of=/dev/sdX conv=fsync status=progress
 ```
 7. Ethernet is configured to use DHCP. Login with user `root` and password `snapcast`
 8. Have fun with the not yet functional, but small and fast booting Raspberry Pi 3 image :)
