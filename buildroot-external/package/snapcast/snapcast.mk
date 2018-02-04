################################################################################
#
# spapcast
#
################################################################################

SNAPCAST_VERSION = 113e71b6
SNAPCAST_SITE = $(call github,badaix,snapcast,$(SNAPCAST_VERSION))
SNAPCAST_DEPENDENCIES = libogg alsa-lib # libstdcpp libavahi-client libatomic libflac libvorbisidec
SNAPCAST_LICENSE = GPL-3.0+
SNAPCAST_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_SNAPCAST_CLIENT),y)
define SNAPCLIENT_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(SNAPCAST_PKGDIR)/S99snapclient $(TARGET_DIR)/etc/init.d/S99snapclient
endef
endif

ifeq ($(BR2_PACKAGE_SNAPCAST_SERVER),y)
define SNAPSERVER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(SNAPCAST_PKGDIR)/S99snapserver $(TARGET_DIR)/etc/init.d/S99snapserver
endef
endif


define SNAPCAST_INSTALL_INIT_SYSV
	$(SNAPCLIENT_INSTALL_INIT_SYSV)
	$(SNAPSERVER_INSTALL_INIT_SYSV)
endef


$(eval $(cmake-package))
