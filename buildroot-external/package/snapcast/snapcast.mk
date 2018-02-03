################################################################################
#
# spapcast
#
################################################################################

SNAPCAST_VERSION = 39b880e6
SNAPCAST_SITE = $(call github,badaix,snapcast,$(SNAPCAST_VERSION))
SNAPCAST_LICENSE = GPL-3.0+
SNAPCAST_LICENSE_FILES = copying.txt

$(eval $(cmake-package))
