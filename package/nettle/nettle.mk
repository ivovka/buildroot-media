#############################################################
#
# nettle
#
#############################################################

NETTLE_VERSION = 2.4
NETTLE_SOURCE = nettle-$(NETTLE_VERSION).tar.gz
NETTLE_SITE = http://www.lysator.liu.se/~nisse/archive
NETTLE_INSTALL_STAGING = YES
NETTLE_BUILD_OPKG = YES
NETTLE_SECTION = security
NETTLE_DESCRIPTION = cryptographic library
NETTLE_DEPENDENCIES = gmp
NETTLE_OPKG_DEPENDENCIES = gmp

NETTLE_CONF_OPT = --disable-openssl

define NETTLE_OPKG_CLEANUP
  rm -rf $(BUILD_DIR_OPKG)/$(NETTLE_BASE_NAME)/usr/bin
endef

NETTLE_PRE_BUILD_OPKG_HOOKS += NETTLE_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package,nettle))
