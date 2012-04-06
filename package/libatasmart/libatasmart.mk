#############################################################
#
# libatasmart
#
#############################################################

LIBATASMART_VERSION = 0.18
LIBATASMART_SITE = http://0pointer.de/public
LIBATASMART_INSTALL_STAGING = YES
LIBATASMART_BUILD_OPKG = YES
LIBATASMART_DEPENDENCIES = udev
LIBATASMART_OPKG_DEPENDENCIES = udev

LIBATASMART_SECTION = system
LIBATASMART_DESCRIPTION = a lean, small and clean implementation of an ATA S.M.A.R.T. reading and parsing library

define LIBATASMART_OPKG_CLEANUP
  rm -rf $(BUILD_DIR_OPKG)/$(LIBATASMART_BASE_NAME)/usr/{sbin,share}
endef

LIBATASMART_PRE_BUILD_OPKG_HOOKS += LIBATASMART_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package,libatasmart))
