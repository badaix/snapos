## OpenWrt/LEDE (Cross compile)
Cross compilation for OpenWrt is done with the [OpenWrt build system](https://wiki.openwrt.org/about/toolchain) on a Linux host machine:  
https://wiki.openwrt.org/doc/howto/build

For LEDE:
https://lede-project.org/docs/guide-developer/quickstart-build-images

### OpenWrt/LEDE build system setup
https://wiki.openwrt.org/doc/howto/buildroot.exigence

Clone OpenWrt to some place in your home directory (`<buildroot dir>`)

    $ git clone git://git.openwrt.org/15.05/openwrt.git
    
...LEDE

    $ git clone https://git.lede-project.org/source.git

Download and install available feeds

    $ cd <buildroot dir>
    $ ./scripts/feeds update -a
    $ ./scripts/feeds install -a

Within the `<buildroot dir>` directory create symbolic links to the Snapcast source directory `<snapcast source>` and to the OpenWrt Makefile:

    $ mkdir -p <buildroot dir>/package/sxx/snapcast
    $ cd <buildroot dir>/package/sxx/snapcast
    $ ln -s <snapcast source> src
    $ ln -s <snapcast source>/openWrt/Makefile.openwrt Makefile

Build  
in menuconfig in `sxx/snapcast` select `Compile snapserver` and/or `Compile snapclient`

    $ cd <buildroot dir>
    $ make defconfig
    $ make menuconfig
    $ make

Rebuild Snapcast:

    $ make package/sxx/snapcast/clean
    $ make package/sxx/snapcast/compile

The packaged `ipk` files are for OpenWrt in `<buildroot dir>/bin/ar71xx/packages/base/snap[client|server]_x.x.x_ar71xx.ipk` and for LEDE `<buildroot dir>/bin/packages/mips_24kc/base/snap[client|server]_x.x.x_mips_24kc.ipk`
