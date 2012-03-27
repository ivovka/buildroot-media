#############################################################
#
# fontconfig
#
#############################################################
FONTCONFIG_VERSION = 2.8.0
FONTCONFIG_SOURCE = fontconfig-$(FONTCONFIG_VERSION).tar.gz
FONTCONFIG_SITE = http://fontconfig.org/release
FONTCONFIG_AUTORECONF = YES
FONTCONFIG_INSTALL_STAGING = YES
FONTCONFIG_INSTALL_TARGET = YES
FONTCONFIG_BUILD_OPKG = YES

FONTCONFIG_SECTION = graphics
FONTCONFIG_PRIORITY = important
FONTCONFIG_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
FONTCONFIG_DESCRIPTION = A library for font customization and configuration
# This package does not like using the target cflags for some reason.
FONTCONFIG_CONF_ENV = CFLAGS="-I$(STAGING_DIR)/usr/include/freetype2"

FONTCONFIG_CONF_OPT = --with-arch=$(GNU_TARGET_NAME) \
		--with-freetype-config="$(STAGING_DIR)/usr/bin/freetype-config" \
		--with-cache-dir=/var/cache/fontconfig \
		--disable-docs \
		--with-default-fonts=/usr/share/fonts/liberation \
		--without-add-fonts

FONTCONFIG_DEPENDENCIES = xutil_util-macros freetype libxml2
FONTCONFIG_OPKG_DEPENDENCIES = freetype,libxml2
HOST_FONTCONFIG_DEPENDENCIES = host-xutil_util-macros host-freetype host-libxml2
HOST_FONTCONFIG_CONF_OPT = \
		--disable-docs \
		--disable-static

$(eval $(call AUTOTARGETS,package,fontconfig))
$(eval $(call AUTOTARGETS,package,fontconfig,host))
