################################################################################
#
# font-util -- No description available
#
################################################################################

XFONT_FONT_UTIL_VERSION = 1.3.0
XFONT_FONT_UTIL_SOURCE = font-util-$(XFONT_FONT_UTIL_VERSION).tar.bz2
XFONT_FONT_UTIL_SITE = http://xorg.freedesktop.org/releases/individual/font
XFONT_FONT_UTIL_DEPENDENCIES = host-pkg-config xutil_util-macros
XFONT_FONT_UTIL_INSTALL_STAGING = YES
XFONT_FONT_UTIL_BUILD_OPKG = YES
XFONT_FONT_UTIL_NAME_OPKG = font-util
XFONT_FONT_UTIL_SECTION = x11
XFONT_FONT_UTIL_DESCRIPTION = X.org font utilities
XFONT_FONT_UTIL_INSTALL_TARGET = YES
XFONT_FONT_UTIL_CONF_OPT += --with-mapdir=/usr/share/fonts/util

HOST_XFONT_FONT_UTIL_DEPENDENCIES = host-pkg-config host-xutil_util-macros

$(eval $(call AUTOTARGETS,package/x11r7,xfont_font-util))
$(eval $(call AUTOTARGETS,package/x11r7,xfont_font-util,host))
