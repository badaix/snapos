################################################################################
#
# jsonrpc++
#
################################################################################

JSONRPCPP_VERSION = v1.0.1
JSONRPCPP_SITE = $(call github,badaix,jsonrpcpp,$(JSONRPCPP_VERSION))
JSONRPCPP_LICENSE = MIT
JSONRPCPP_LICENSE_FILES = copying.txt

JSONRPCPP_INSTALL_STAGING = YES
JSONRPCPP_INSTALL_TARGET = YES

$(eval $(cmake-package))
