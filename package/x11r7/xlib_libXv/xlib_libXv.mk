################################################################################
#
# xlib_libXv -- X.Org Xv library
#
################################################################################

XLIB_LIBXV_VERSION = 1.0.7
XLIB_LIBXV_SOURCE = libXv-$(XLIB_LIBXV_VERSION).tar.bz2
XLIB_LIBXV_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXV_AUTORECONF = NO
XLIB_LIBXV_INSTALL_STAGING = YES
XLIB_LIBXV_BUILD_OPKG = YES

XLIB_LIBXV_SECTION = x11
XLIB_LIBXV_DESCRIPTION = X.Org Xv library
XLIB_LIBXV_DEPENDENCIES = xlib_libX11 xlib_libXext xproto_videoproto xproto_xproto
XLIB_LIBXV_OPKG_DEPENDENCIES = libx11,libxext
XLIB_LIBXV_NAME_OPKG = libxv
XLIB_LIBXV_CONF_OPT = --disable-malloc0returnsnull

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXv))
