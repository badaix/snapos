#
#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libpopl
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/badaix/popl.git
PKG_SOURCE_VERSION:=v1.0.0

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk


define Package/libpopl
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=popl
  URL:=https://github.com/badaix/popl
endef

define Package/libpopl/description
 Header-only C++ program options parser library
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/popl.hpp $(1)/usr/include/
endef

$(eval $(call BuildPackage,libpopl))
