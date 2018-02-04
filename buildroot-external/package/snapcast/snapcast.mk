################################################################################
#
# spapcast
#
################################################################################

SNAPCAST_VERSION = fc075555
SNAPCAST_SITE = $(call github,badaix,snapcast,$(SNAPCAST_VERSION))
SNAPCAST_DEPENDENCIES = libogg alsa-lib # libstdcpp libavahi-client libatomic libflac libvorbisidec
SNAPCAST_LICENSE = GPL-3.0+
SNAPCAST_LICENSE_FILES = LICENSE

define SNAPCAST_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(SNAPCAST_PKGDIR)/S99snapclient $(TARGET_DIR)/etc/init.d/S99snapclient
endef


$(eval $(cmake-package))
