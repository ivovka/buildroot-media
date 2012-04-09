#############################################################
#
# libplist
#
#############################################################
LIBPLIST_VERSION = 1.4
LIBPLIST_SOURCE = libplist-$(LIBPLIST_VERSION).tar.bz2
LIBPLIST_SITE = http://www.libimobiledevice.org/downloads/
LIBPLIST_INSTALL_STAGING = YES
LIBPLIST_INSTALL_TARGET = YES
LIBPLIST_BUILD_OPKG = YES
LIBPLIST_SECTION = devel
LIBPLIST_DESCRIPTION = a library for manipulating Apple Binary and XML Property Lists
LIBPLIST_OPKG_DEPENDENCIES = libxml2,libglib2
LIBPLIST_DEPENDENCIES = libxml2 libglib2
LIBPLIST_CONF_OPT = -DENABLE_PYTHON="OFF"

define LIBPLIST_OPKG_CLEANUP
  rm -rf $(BUILD_DIR_OPKG)/$(LIBPLIST_BASE_NAME)/usr/bin
endef

LIBPLIST_PRE_BUILD_OPKG_HOOKS += LIBPLIST_OPKG_CLEANUP
$(eval $(call CMAKETARGETS,package,libplist))
