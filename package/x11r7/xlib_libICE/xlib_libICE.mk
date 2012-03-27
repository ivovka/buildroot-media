################################################################################
#
# xlib_libICE -- X.Org ICE library
#
################################################################################

XLIB_LIBICE_VERSION = 1.0.8
XLIB_LIBICE_SOURCE = libICE-$(XLIB_LIBICE_VERSION).tar.bz2
XLIB_LIBICE_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBICE_AUTORECONF = NO
XLIB_LIBICE_INSTALL_STAGING = YES
XLIB_LIBICE_BUILD_OPKG = YES

XLIB_LIBICE_NAME_OPKG = libice
XLIB_LIBICE_SECTION = x11
XLIB_LIBICE_DESCRIPTION = X Inter-Client Exchange (ICE) protocol library
XLIB_LIBICE_OPKG_DEPENDENCIES = xtrans

XLIB_LIBICE_DEPENDENCIES = xutil_util-macros xlib_xtrans xproto_xproto

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libICE))
