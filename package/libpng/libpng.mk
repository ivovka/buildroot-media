#############################################################
#
# libpng (Portable Network Graphic library)
#
#############################################################
LIBPNG_VERSION = 1.5.10
LIBPNG_SERIES = 15
LIBPNG_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/libpng
LIBPNG_SOURCE = libpng-$(LIBPNG_VERSION).tar.bz2
LIBPNG_INSTALL_STAGING = YES
LIBPNG_BUILD_OPKG = YES
LIBPNG_DEPENDENCIES = host-pkg-config zlib
LIBPNG_OPKG_DEPENDENCIES = zlib
HOST_LIBPNG_DEPENDENCIES = host-pkg-config host-zlib

LIBPNG_SECTION = graphics
LIBPNG_DESCRIPTION = Portable Network Graphics (PNG) Reference Library

LIBPNG_CONF_ENV += ac_cv_lib_z_zlibVersion=yes

define LIBPNG_STAGING_LIBPNG12_CONFIG_FIXUP
	$(SED) "s,^prefix=.*,prefix=\'$(STAGING_DIR)/usr\',g" \
		-e "s,^exec_prefix=.*,exec_prefix=\'$(STAGING_DIR)/usr\',g" \
		-e "s,^includedir=.*,includedir=\'$(STAGING_DIR)/usr/include/libpng$(LIBPNG_SERIES)\',g" \
		-e "s,^libdir=.*,libdir=\'$(STAGING_DIR)/usr/lib\',g" \
		$(STAGING_DIR)/usr/bin/libpng$(LIBPNG_SERIES)-config
endef

LIBPNG_POST_INSTALL_STAGING_HOOKS += LIBPNG_STAGING_LIBPNG12_CONFIG_FIXUP

define LIBPNG_REMOVE_CONFIG_SCRIPTS
	$(RM) -f $(TARGET_DIR)/usr/bin/libpng$(LIBPNG_SERIES)-config \
		 $(TARGET_DIR)/usr/bin/libpng-config
endef

ifneq ($(BR2_HAVE_DEVFILES),y)
LIBPNG_POST_INSTALL_TARGET_HOOKS += LIBPNG_REMOVE_CONFIG_SCRIPTS
endif

define LIBPNG_OPKG_RM_BIN
  rm -rf $(BUILD_DIR_OPKG)/$(LIBPNG_BASE_NAME)/usr/bin
endef

LIBPNG_PRE_BUILD_OPKG_HOOKS += LIBPNG_OPKG_RM_BIN

$(eval $(call AUTOTARGETS,package,libpng))
$(eval $(call AUTOTARGETS,package,libpng,host))
