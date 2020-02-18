# OpenWrt flavored SnapOS
Cross compilation for OpenWrt is done with the [OpenWrt build system](https://openwrt.org/docs/guide-developer/build-system/start) on a Linux host machine:  
https://openwrt.org/docs/guide-developer/build-system/install-buildsystem

## OpenWrt build system setup
https://openwrt.org/docs/guide-developer/build-system/install-buildsystem

### Get OpenWrt
Clone OpenWrt to some place in your home directory (`<wrt dir>`)

    $ git clone https://git.openwrt.org/openwrt/openwrt.git

### Check prerequisites

```
make prereq
```

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

