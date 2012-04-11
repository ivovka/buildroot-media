################################################################################
#
# xlib_libXmu -- X.Org Xmu library
#
################################################################################

XLIB_LIBXMU_VERSION = 1.1.1
XLIB_LIBXMU_SOURCE = libXmu-$(XLIB_LIBXMU_VERSION).tar.bz2
XLIB_LIBXMU_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXMU_AUTORECONF = NO
XLIB_LIBXMU_INSTALL_STAGING = YES
XLIB_LIBXMU_BUILD_OPKG = YES

XLIB_LIBXMU_NAME_OPKG = libxmu
XLIB_LIBXMU_SECTION = x11
XLIB_LIBXMU_DESCRIPTION = X11 miscellaneous utility library
XLIB_LIBXMU_OPKG_DEPENDENCIES = libxext,libx11,libxt

XLIB_LIBXMU_DEPENDENCIES = xlib_libX11 xlib_libXext xlib_libXt xproto_xproto xproto_xextproto xutil_util-macros

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXmu))
