################################################################################
#
# xlib_libXt -- X.Org Xt library
#
################################################################################

XLIB_LIBXT_VERSION = 1.1.2
XLIB_LIBXT_SOURCE = libXt-$(XLIB_LIBXT_VERSION).tar.bz2
XLIB_LIBXT_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXT_AUTORECONF = YES
XLIB_LIBXT_INSTALL_STAGING = YES
XLIB_LIBXT_BUILD_OPKG = YES

XLIB_LIBXT_NAME_OPKG = libxt
XLIB_LIBXT_SECTION = x11
XLIB_LIBXT_DESCRIPTION = X11 toolkit intrinsics library
XLIB_LIBXT_OPKG_DEPENDENCIES = libsm,libx11,libxcb

XLIB_LIBXT_DEPENDENCIES = xlib_libSM xlib_libX11 xproto_kbproto xproto_xproto xcb-proto libxcb host-xproto_xproto
XLIB_LIBXT_CONF_OPT = --enable-malloc0returnsnull

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXt))
