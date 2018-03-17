################################################################################
#
# asio
#
################################################################################

ASIO_VERSION = asio-1-12-0
ASIO_SITE = $(call github,chriskohlhoff,asio,$(ASIO_VERSION))
ASIO_LICENSE = Boost Software License 1.0
ASIO_LICENSE_FILES = COPYING, LICENSE_1_0.txt

ASIO_SUBDIR = asio

# patching configure.ac and Makefile.am
ASIO_AUTORECONF = YES

ASIO_CONF_OPTS = --disable-examples --disable-tests

# Only installs headers
ASIO_INSTALL_TARGET = NO
ASIO_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_BOOST),y)
ASIO_DEPENDENCIES += boost
ASIO_CONF_OPTS += --with-boost=yes
ifeq ($(BR2_PACKAGE_BOOST_COROUTINE),y)
ASIO_CONF_OPTS += --enable-boost-coroutine
endif
else
ASIO_CONF_OPTS += --with-boost=no
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
ASIO_DEPENDENCIES += openssl
ASIO_CONF_OPTS += --with-openssl=yes
else
ASIO_CONF_OPTS += --with-openssl=no
endif

$(eval $(autotools-package))
