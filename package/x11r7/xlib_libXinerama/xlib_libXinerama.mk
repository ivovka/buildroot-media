################################################################################
#
# xlib_libXinerama -- X.Org Xinerama library
#
################################################################################

XLIB_LIBXINERAMA_VERSION = 1.1.2
XLIB_LIBXINERAMA_SOURCE = libXinerama-$(XLIB_LIBXINERAMA_VERSION).tar.bz2
XLIB_LIBXINERAMA_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXINERAMA_AUTORECONF = NO
XLIB_LIBXINERAMA_INSTALL_STAGING = YES
XLIB_LIBXINERAMA_BUILD_OPKG = YES
XLIB_LIBXINERAMA_NAME_OPKG = libxinerama
XLIB_LIBXINERAMA_SECTION = x11
XLIB_LIBXINERAMA_DESCRIPTION = Xinerama extension library
XLIB_LIBXINERAMA_OPKG_DEPENDENCIES = libxext
XLIB_LIBXINERAMA_DEPENDENCIES = xutil_util-macros xlib_libXext xproto_xineramaproto
XLIB_LIBXINERAMA_CONF_OPT = --enable-malloc0returnsnull

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXinerama))
