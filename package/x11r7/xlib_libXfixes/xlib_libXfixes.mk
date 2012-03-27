################################################################################
#
# xlib_libXfixes -- X.Org Xfixes library
#
################################################################################

XLIB_LIBXFIXES_VERSION = 5.0
XLIB_LIBXFIXES_SOURCE = libXfixes-$(XLIB_LIBXFIXES_VERSION).tar.bz2
XLIB_LIBXFIXES_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXFIXES_AUTORECONF = NO
XLIB_LIBXFIXES_INSTALL_STAGING = YES
XLIB_LIBXFIXES_BUILD_OPKG = YES

XLIB_LIBXFIXES_NAME_OPKG = libxfixes
XLIB_LIBXFIXES_SECTION = x11
XLIB_LIBXFIXES_DESCRIPTION = X Fixes Library
XLIB_LIBXFIXES_OPKG_DEPENDENCIES = libx11

XLIB_LIBXFIXES_DEPENDENCIES = xproto_fixesproto xlib_libX11 xproto_xextproto xproto_xproto

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXfixes))
