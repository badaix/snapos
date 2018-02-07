################################################################################
#
# jsonrpc++
#
################################################################################

JSONRPCPP_VERSION = v1.1.0
JSONRPCPP_SITE = $(call github,badaix,jsonrpcpp,$(JSONRPCPP_VERSION))
JSONRPCPP_LICENSE = MIT
JSONRPCPP_LICENSE_FILES = LICENSE

JSONRPCPP_INSTALL_STAGING = YES
JSONRPCPP_INSTALL_TARGET = YES

$(eval $(cmake-package))
