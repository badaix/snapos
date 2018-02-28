#
#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libjsonrpcpp
PKG_VERSION:=1.1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/badaix/jsonrpcpp.git
PKG_SOURCE_VERSION:=v1.1.0

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk


define Package/libjsonrpcpp
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=jsonrpc++
  DEPENDS:= +libstdcpp
  URL:=https://github.com/badaix/jsonrpcpp
endef

define Package/libjsonrpcpp/description
 C++ JSON-RPC 2.0 library
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/jsonrpcpp
	$(CP) $(PKG_INSTALL_DIR)/usr/include/jsonrpcpp/* $(1)/usr/include/jsonrpcpp/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libjsonrpcpp.{a,so} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/jsonrpcpp.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libjsonrpcpp/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libjsonrpcpp.so $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libjsonrpcpp))
