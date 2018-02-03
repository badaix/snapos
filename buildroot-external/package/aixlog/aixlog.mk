################################################################################
#
# aixlog
#
################################################################################

AIXLOG_VERSION = v1.0.4
AIXLOG_SITE = $(call github,badaix,aixlog,$(AIXLOG_VERSION))
AIXLOG_LICENSE = MIT
AIXLOG_LICENSE_FILES = copying.txt

# aixlog is a header-only library, it only makes sense
# to have it installed into the staging directory.
AIXLOG_INSTALL_STAGING = YES
AIXLOG_INSTALL_TARGET = NO

$(eval $(cmake-package))
