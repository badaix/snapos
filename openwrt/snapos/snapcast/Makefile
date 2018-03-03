#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME := snapcast
PKG_VERSION := 0.13.0
PKG_RELEASE := $(PKG_SOURCE_VERSION)
PKG_USE_MIPS16 := 0

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/badaix/snapcast.git
PKG_SOURCE_VERSION:=a3f309e0da291dcbec14520f4f8f44a739184ddf
#v0.12.0
PKG_BUILD_DIR:=$(BUILD_DIR)/snapcast-$(PKG_VERSION)
PKG_BUILD_DEPENDS := asio popl aixlog

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/snapcast/Default
	SECTION := multimedia
	CATEGORY := Multimedia
	TITLE := snapcast
	DEPENDS := +libstdcpp +libavahi-client +libatomic +libogg +libflac
endef

define Package/snapcast/description/Default
	Synchronous audio player
endef

define Package/snapcast
	$(call Package/snapcast/Default)
	TITLE += packages
endef

define Package/snapcast/description
	$(call Package/snapcast/description/Default)
	Multi-room client-server audio player
	Include Server and Client
endef

define Package/snapserver
	$(call Package/snapcast/Default)
	TITLE += snapserver
	DEPENDS += +libvorbis
	HIDDEN := 1
endef

define Package/snapclient
	$(call Package/snapcast/Default)
	TILE += snapclient
	DEPENDS += +alsa-lib +libvorbisidec
	HIDDEN := 1
endef

define Package/snapserver/description
	$(call Package/snapcast/description/Default)
	Snapcast server
endef

define Package/snapclient/description
	$(call Package/snapcast/description/Default)
	Snapcast client
endef

define Package/snapcast/config
 	menu "Select snapcast Options"
		depends on PACKAGE_snapcast
		comment "Choose server or client"
		config PACKAGE_snapserver
			prompt "snapserver"
			help
				Snapcast server
			default n

		config PACKAGE_snapclient
			prompt "snapclient"
			help
				Snapcast client
			default n
	endmenu
endef


define Build/Prepare
	# copy package config file for tremor, 
	# as this is not done by the original package and snapcast relies on it
	$(call Build/Prepare/Default)
	$(INSTALL_DIR) $(STAGING_DIR)/usr/lib/pkgconfig/
	$(INSTALL_DATA) ./files/vorbisidec.pc $(STAGING_DIR)/usr/lib/pkgconfig/

#	$(CP) -r src/common/ $(PKG_BUILD_DIR)
#	$(CP) -r src/message/ $(PKG_BUILD_DIR)
#	$(CP) -r src/externals/ $(PKG_BUILD_DIR)
#	$(CP) -r src/openWrt/ $(PKG_BUILD_DIR)
#	$(if $(CONFIG_PACKAGE_snapserver), \
#		$(CP) -r src/server/ $(PKG_BUILD_DIR),)
#	$(if $(CONFIG_PACKAGE_snapclient), \
#		$(CP) -r src/client/ $(PKG_BUILD_DIR),)
endef


define Package/snapcast/Default/install
	true
endef

define Package/snapserver/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/snapserver $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/snapserver.init $(1)/etc/init.d/snapserver
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/server/debian/snapserver.default $(1)/etc/default/snapserver
endef

define Package/snapclient/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/snapclient $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/snapclient.init $(1)/etc/init.d/snapclient
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/client/debian/snapclient.default $(1)/etc/default/snapclient
endef

$(eval $(call BuildPackage,snapserver))
$(eval $(call BuildPackage,snapclient))
$(eval $(call BuildPackage,snapcast))
