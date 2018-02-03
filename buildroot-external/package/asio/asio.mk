################################################################################
#
# asio
#
################################################################################

ASIO_VERSION = 28d9b8d6df708024af5227c551673fdb2519f5bf
ASIO_SITE = $(call github,chriskohlhoff,asio,$(ASIO_VERSION))
ASIO_LICENSE = Boost Software License
ASIO_LICENSE_FILES = LICENSE_1_0.txt

# asio is a header-only library, it only makes sense
# to have it installed into the staging directory.
ASIO_INSTALL_STAGING = YES
ASIO_INSTALL_TARGET = NO

$(eval $(cmake-package))
