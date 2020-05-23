# OpenWrt flavored SnapOS
Cross compilation for OpenWrt is done with the [OpenWrt build system](https://openwrt.org/docs/guide-developer/build-system/start) on a Linux host machine:  
https://openwrt.org/docs/guide-developer/build-system/install-buildsystem

## OpenWrt build system setup
https://openwrt.org/docs/guide-developer/build-system/install-buildsystem

### Get OpenWrt
Clone OpenWrt to some place in your home directory (`<wrt dir>`)

    $ git clone https://git.openwrt.org/openwrt/openwrt.git

### Download and install available feeds 

```
$ cd <wrt dir>
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

### Add snapcast
Within the `<wrt dir>/package` directory create a symbolic link to `<snapos dir>/openwrt`: 

```
$ cd <wrt dir>
$ ln -s <snapos dir>/openwrt package/snapcast
```

### Build  
In `make menuconfig` navigate to `Sound/snapcast` and select `Snapserver` and/or `Snapclient`

```
$ cd <wrt dir>
$ make defconfig
$ make menuconfig
$ make
```

#### Rebuild Snapcast:
If there is an update for snapcast available, it can be rebuilt like this:
```
$ cd <wrt dir>
$ make package/snapcast/snapcast/clean
$ make package/snapcast/snapcast/compile
```

The packaged `ipk` files are in  
```
<wrt dir>/bin/packages/<pkg_arch>/base/snapclient_x.x.x_<pkg_arch>.ipk
<wrt dir>/bin/packages/<pkg_arch>/base/snapserver_x.x.x_<pkg_arch>.ipk
```

## Alternative: Using OpenWRT-SDK
https://openwrt.org/docs/guide-developer/using_the_sdk

Instead of building the entire image including snapcast and all dependencies, this methods uses the so called OpenWRT-SDK to only build the package and install it to an official vanilla OpenWRT build for your device.

### Advantages:
- faster
- uses less disk space while building
- less prone to dependency related errors
### Disadvantages:
- only works for systems with available official builds
- if SnapOS would optimize the base OpenWRT-System (currently it doesn't), these changes would not be reflected by this method

### Instructions
#### Get the base image for your device
General remarks:
- At time of writing we use OpenWRT version 19.07.2.
- In this example snapcast is built for a TP-Link TL-WR710 v2.1.

Find your device's page, e.g. https://openwrt.org/toh/tp-link/tl-wr710n

download the latest image from there: http://downloads.openwrt.org/releases/19.07.2/targets/ar71xx/generic/openwrt-19.07.2-ar71xx-generic-tl-wr710n-v2.1-squashfs-factory.bin

note down your device's architecture:
- ar71xx/generic

#### Get OpenWRT-SDK
Download the latest release of the SDK for your architecture and unpack:

    $ wget https://downloads.openwrt.org/releases/19.07.2/targets/ar71xx/generic/openwrt-sdk-19.07.2-ar71xx-generic_gcc-7.5.0_musl.Linux-x86_64.tar.xz
    $ tar -xf openwrt-sdk-19.07.2-ar71xx-generic_gcc-7.5.0_musl.Linux-x86_64.tar.xz

#### Add snapcast
Within the `<wrt-sdk dir>/package` directory create a symbolic link to `<snapos dir>/openwrt`: 
```
$ cd <wrt-sdk dir>
$ ln -s <snapos dir>/openwrt package/snapcast
```

#### Download and install available feeds 
```
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

#### Build  
In `make menuconfig` navigate to `Sound/snapcast` and select `Snapclient`

Also make sure to select your device in the target settings.

```
$ cd <wrt dir>
$ make defconfig
$ make menuconfig
$ make
```

The packaged `ipk` file is in  
```
<wrt dir>/bin/packages/<pkg_arch>/base/snapclient_x.x.x_<pkg_arch>.ipk
```

#### Install on device
Assuming you already have installed OpenWRT on your device, you now have to copy the `ipk` to the device, e.g. with scp:
```
$ scp <wrt-sdk dir>/bin/packages/<pkg_arch>/base/snapclient_x.x.x_<pkg_arch>.ipk <openWRT-IP>:/tmp/
```
SSH to your device to install:
```
# update package manager to be able to install dependencies:
$ opkg update
# if you are using a usb soundcard you will need:
$ opkg install kmod-usb-audio
# finally install the copied package:
$ opkg install /tmp/snapclient_0.19.0_mips_24kc.ipk
```
set your default options, e.g.:
```
$ vi /etc/default/snapclient
  SNAPCLIENT_OPTS="-d -h <snapserver-ip> -s 3"
```
after a reboot you should be all set:
```
$ reboot
```
