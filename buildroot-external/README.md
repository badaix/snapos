# Buildroot flavored SnapOS
[Buildroot](https://buildroot.org) based embedded [Linux](https://www.kernel.org) OS for [Snapcast](https://github.com/badaix/snapcast).
There are configurations for some boards, e.g. the Raspberry Pi 3 with WiFi and audio enabled, as well as packages for Snapcast and its dependencies.

## How-to
 1. [Download](https://buildroot.org/download.html) or [clone](https://github.com/buildroot/buildroot) [Buildroot](https://buildroot.org) 
 2. Clone SnapOS to some directory
 3. Navigate into Buildroot's root directory and define SnapOS as an [external](https://buildroot.org/downloads/manual/manual.html#outside-br-custom):
```
buildroot-2017.11.2 $ make BR2_EXTERNAL=/PATH/TO/snapos/buildroot-external/ snapos_rpi3_defconfig
```
 4. Now you will find the pre-selected `Snapclient` package under `External options  --->` in `make menuconfig`
```
    *** Snapcast OS (in /PATH/TO/snapos/buildroot-external) ***
[*] Snapcast
[*]   Snapclient
[ ]   Snapserver
-*- aixlog
-*- jsonrpc++
-*- popl
-*- asio
```
 5. Run `make`, wait, and find the image in `output/image/sdcard.img`
 6. Write the image to an sd card, e.g. (with `sdX` = your sd card's device name):
 ```
 buildroot-2017.11.2 $ sudo dd bs=4M if=output/images/sdcard.img of=/dev/sdX conv=fsync status=progress
 ```
 7. Boot your device. Snapclient will start automatically
 8. Ethernet is configured to use DHCP. Login with user `root` and password `snapcast`

### WiFi
To enable WiFi, add your WiFi's SSID and password to `/etc/wpa_supplicant.conf`:
```
ctrl_interface=/var/run/wpa_supplicant
ap_scan=1

network={
    ssid=<Your SSID>
    psk="<Your Key>"
}
```

### External DAC
You can activate support for external DACs by loading the appropriate device tree: 
#### 1. Remove the driver for the onboard sound  
Remove the line from `/boot/config.txt`:
 ```
 dtparam=audio=on
 ```
#### 2. Configure device tree overlay file  
add your DAC's device tree (e.g. `hifiberry-dac`) to `/boot/config.txt`:
```
dtoverlay=<your DAC's device tree>
```

