#############################################################
#
# fontconfig
#
#############################################################
FONTCONFIG_VERSION = 2.9.0
FONTCONFIG_SOURCE = fontconfig-$(FONTCONFIG_VERSION).tar.gz
FONTCONFIG_SITE = http://fontconfig.org/release
FONTCONFIG_AUTORECONF = YES
FONTCONFIG_INSTALL_STAGING = YES
FONTCONFIG_INSTALL_TARGET = YES
FONTCONFIG_BUILD_OPKG = YES
FONTCONFIG_DEPENDENCIES = xutil_util-macros freetype libxml2 zlib
FONTCONFIG_OPKG_DEPENDENCIES = freetype,libxml2,zlib
HOST_FONTCONFIG_DEPENDENCIES = host-xutil_util-macros host-freetype host-libxml2

FONTCONFIG_SECTION = graphics
FONTCONFIG_PRIORITY = important
FONTCONFIG_DESCRIPTION = A library for font customization and configuration
# This package does not like using the target cflags for some reason.
#FONTCONFIG_CONF_ENV = CFLAGS="-I$(STAGING_DIR)/usr/include/freetype2"

FONTCONFIG_CONF_OPT = --with-arch=$(GNU_TARGET_NAME) \
		--with-freetype-config="$(STAGING_DIR)/usr/bin/freetype-config" \
		--with-cache-dir=/var/cache/fontconfig \
		--disable-docs \
		--with-default-fonts=/usr/share/fonts/liberation \
		--without-add-fonts

HOST_FONTCONFIG_CONF_OPT = \
		--disable-docs \
		--disable-static

define FONTCONFING_CLEANUP_OPKG
  rm -rf $(BUILD_DIR_OPKG)/$(FONTCONFIG_BASE_NAME)/var
endef

FONTCONFIG_PRE_BUILD_OPKG_HOOKS += FONTCONFIG_CLEANUP_OPKG

$(eval $(call AUTOTARGETS,package,fontconfig))
$(eval $(call AUTOTARGETS,package,fontconfig,host))
