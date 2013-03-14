#############################################################
#
# taglib
#
#############################################################
TAGLIB_VERSION = 1.8
TAGLIB_SOURCE = taglib-$(TAGLIB_VERSION).tar.gz
TAGLIB_SITE = http://developer.kde.org/~wheeler/files/src
TAGLIB_LIBTOOL_PATCH = NO
TAGLIB_INSTALL_STAGING = YES
TAGLIB_BUILD_OPKG = YES

TAGLIB_SECTION = libs
TAGLIB_PRIORITY = optional
TAGLIB_DESCRIPTION = a library for reading and editing the meta-data of several popular audio formats
TAGLIB_OPKG_DEPENDENCIES = zlib
TAGLIB_DEPENDENCIES = zlib

TAGLIB_CONF_ENV = \
	DO_NOT_COMPILE='bindings tests examples' \
	ac_cv_header_cppunit_extensions_HelperMacros_h=no \
	ac_cv_header_zlib_h=$(if $(BR2_PACKAGE_ZLIB),yes,no)

define TAGLIB_REMOVE_DEVFILE
	rm -f $(TARGET_DIR)/usr/bin/taglib-config
endef

define TAGLIB_REMOVE_DEVFILE_OPKG
	rm -f $(BUILD_DIR_OPKG)/$(TAGLIB_BASE_NAME)/usr/bin/taglib-config
endef

ifneq ($(BR2_HAVE_DEVFILES),y)
TAGLIB_POST_INSTALL_TARGET_HOOKS += TAGLIB_REMOVE_DEVFILE
TAGLIB_PRE_BUILD_OPKG_HOOKS += TAGLIB_REMOVE_DEVFILE_OPKG
endif

$(eval $(call CMAKETARGETS,package/multimedia,taglib))
