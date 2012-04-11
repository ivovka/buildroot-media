################################################################################
#
# xlib_libXft -- X.Org Xft library
#
################################################################################

XLIB_LIBXFT_VERSION = 2.3.0
XLIB_LIBXFT_SOURCE = libXft-$(XLIB_LIBXFT_VERSION).tar.bz2
XLIB_LIBXFT_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXFT_AUTORECONF = YES
XLIB_LIBXFT_INSTALL_STAGING = YES
XLIB_LIBXFT_BUILD_OPKG = YES
XLIB_LIBXFT_NAME_OPKG = libxft
XLIB_LIBXFT_SECTION = x11
XLIB_LIBXFT_DESCRIPTION = X FreeType library
XLIB_LIBXFT_DEPENDENCIES = fontconfig freetype xlib_libXrender xproto_xproto xutil_util-macros
XLIB_LIBXFT_OPKG_DEPENDENCIES = fontconfig,freetype,libxrender

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXft))
