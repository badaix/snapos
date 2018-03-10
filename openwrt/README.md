# OpenWrt/LEDE flavored SnapOS
Cross compilation for OpenWrt is done with the [OpenWrt build system](https://wiki.openwrt.org/about/toolchain) on a Linux host machine:  
https://wiki.openwrt.org/doc/howto/build

For LEDE: 
https://lede-project.org/docs/guide-developer/quickstart-build-images

## OpenWrt/LEDE build system setup
https://wiki.openwrt.org/doc/howto/buildroot.exigence

### Get OpenWrt/LEDE
Clone OpenWrt to some place in your home directory (`<wrt dir>`)

    $ git clone https://github.com/openwrt/openwrt.git

...LEDE 

    $ git clone https://git.lede-project.org/source.git

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
$ ln -s <snapos dir>/openwrt package/snapos
```

### Build  
In `make menuconfig` navigate to `Multimedia/snapcast` and select `snapserver` and/or `snapclient`

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
$ make package/snapos/snapcast/clean
$ make package/snapos/snapcast/compile
```

The packaged `ipk` files are in  
```
<wrt dir>/bin/<pkg_arch>/packages/base/snapclient_x.x.x_<pkg_arch>.ipk
<wrt dir>/bin/<pkg_arch>/packages/base/snapserver_x.x.x_<pkg_arch>.ipk
```

