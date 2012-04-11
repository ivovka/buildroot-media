################################################################################
#
# xlib_libXrender -- X.Org Xrender library
#
################################################################################

XLIB_LIBXRENDER_VERSION = 0.9.7
XLIB_LIBXRENDER_SOURCE = libXrender-$(XLIB_LIBXRENDER_VERSION).tar.bz2
XLIB_LIBXRENDER_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXRENDER_AUTORECONF = NO
XLIB_LIBXRENDER_INSTALL_STAGING = YES
XLIB_LIBXRENDER_DEPENDENCIES = xlib_libX11 xproto_renderproto xproto_xproto xutil_util-macros
XLIB_LIBXRENDER_CONF_OPT = --enable-malloc0returnsnull
XLIB_LIBXRENDER_BUILD_OPKG = YES
XLIB_LIBXRENDER_NAME_OPKG = libxrender
XLIB_LIBXRENDER_SECTION = x11
XLIB_LIBXRENDER_DESCRIPTION = X Rendering Extension client library
XLIB_LIBXRENDER_OPKG_DEPENDENCIES = libx11

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXrender))
