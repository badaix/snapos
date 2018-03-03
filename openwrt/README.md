# OpenWrt/LEDE flavored SnapOS
Cross compilation for OpenWrt is done with the [OpenWrt build system](https://wiki.openwrt.org/about/toolchain) on a Linux host machine:  
https://wiki.openwrt.org/doc/howto/build

For LEDE: 
https://lede-project.org/docs/guide-developer/quickstart-build-images

## OpenWrt/LEDE build system setup
https://wiki.openwrt.org/doc/howto/buildroot.exigence

### Get OpenWrt/LEDE
Clone OpenWrt to some place in your home directory (`<wrt dir>`)

    $ git clone git://git.openwrt.org/15.05/openwrt.git

...LEDE 

    $ git clone https://git.lede-project.org/source.git

### Download and install available feeds 

```
$ cd <wrt dir>
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

### Add snapcast
Within the `<wrt dir>/package` directory create a symbolic link to `<snapos dir>/openwrt/snapos`: 

```
$ cd <wrt dir>
$ ln -s <snapos dir>/openwrt/snapos/ package/
```

### Build  
in menuconfig in `Multimedia/snapcast` select `snapserver` and/or `snapclient`

```
$ cd <wrt dir>
$ make defconfig
$ make menuconfig
$ make
```

#### Rebuild Snapcast:

```
$ cd <wrt dir>
$ make package/sxx/snapcast/clean
$ make package/sxx/snapcast/compile
```

The packaged `ipk` files for OpenWrt are in  
`<wrt dir>/bin/ar71xx/packages/base/snap[client|server]_x.x.x_ar71xx.ipk`  
and for LEDE  
`<wrt dir>/bin/packages/mips_24kc/base/snap[client|server]_x.x.x_mips_24kc.ipk`
