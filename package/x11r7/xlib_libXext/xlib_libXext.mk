################################################################################
#
# xlib_libXext -- X.Org Xext library
#
################################################################################

XLIB_LIBXEXT_VERSION = 1.3.1
XLIB_LIBXEXT_SOURCE = libXext-$(XLIB_LIBXEXT_VERSION).tar.bz2
XLIB_LIBXEXT_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXEXT_AUTORECONF = NO
XLIB_LIBXEXT_INSTALL_STAGING = YES
XLIB_LIBXEXT_BUILD_OPKG = YES

XLIB_LIBXEXT_NAME_OPKG = libxext
XLIB_LIBXEXT_SECTION = x11
XLIB_LIBXEXT_DESCRIPTION = X11 miscellaneous extensions library
XLIB_LIBXEXT_OPKG_DEPENDENCIES = libx11

XLIB_LIBXEXT_DEPENDENCIES = xlib_libX11 xproto_xextproto xproto_xproto xutil_util-macros
XLIB_LIBXEXT_CONF_OPT = --enable-malloc0returnsnull

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXext))
