################################################################################
#
# aixlog
#
################################################################################

AIXLOG_VERSION = v1.2.1
AIXLOG_SITE = $(call github,badaix,aixlog,$(AIXLOG_VERSION))
AIXLOG_LICENSE = MIT
AIXLOG_LICENSE_FILES = LICENSE

# aixlog is a header-only library, it only makes sense
# to have it installed into the staging directory.
AIXLOG_INSTALL_STAGING = YES
AIXLOG_INSTALL_TARGET = NO

AIXLOG_CONF_OPTS += -DBUILD_EXAMPLE=OFF

$(eval $(cmake-package))
