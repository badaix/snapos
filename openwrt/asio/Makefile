#
#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libasio
PKG_VERSION:=1.12.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/chriskohlhoff/asio.git
PKG_SOURCE_VERSION:=asio-1-12-0

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

MAKE_PATH:=asio
CONFIGURE_PATH:=asio
#TARGET_CFLAGS += $(FPIC)

define Package/libasio
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=asio
  URL:=http://think-async.com/Asio
endef

define Package/libasio/description
 Asio is a cross-platform C++ library for network and
 low-level I/O programming that provides developers with a
 consistent asynchronous model using a modern C++ approach.
endef

CONFIGURE_ARGS += \
	--disable-examples \
	--disable-tests \
	--with-boost=no

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/asio
	$(CP) $(PKG_BUILD_DIR)/asio/include/asio.hpp $(1)/usr/include/
	$(CP) $(PKG_BUILD_DIR)/asio/include/asio/* $(1)/usr/include/asio/
endef

$(eval $(call BuildPackage,libasio))
