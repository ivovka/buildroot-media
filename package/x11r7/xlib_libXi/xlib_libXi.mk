################################################################################
#
# xlib_libXi -- X.Org Xi library
#
################################################################################

XLIB_LIBXI_VERSION = 1.4.3
XLIB_LIBXI_SOURCE = libXi-$(XLIB_LIBXI_VERSION).tar.bz2
XLIB_LIBXI_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXI_AUTORECONF = NO
XLIB_LIBXI_INSTALL_STAGING = YES
XLIB_LIBXI_BUILD_OPKG = YES
XLIB_LIBXI_NAME_OPKG = libxi
XLIB_LIBXI_SECTION = x11
XLIB_LIBXI_DESCRIPTION = X11 Input extension library
XLIB_LIBXI_OPKG_DEPENDENCIES = libx11
XLIB_LIBXI_DEPENDENCIES = xutil_util-macros xproto_inputproto xlib_libX11 xlib_libXext xproto_xproto
XLIB_LIBXI_CONF_OPT = --enable-malloc0returnsnull

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXi))
