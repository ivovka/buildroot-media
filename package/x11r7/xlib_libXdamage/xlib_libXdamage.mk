################################################################################
#
# xlib_libXdamage -- X.Org Xdamage library
#
################################################################################

XLIB_LIBXDAMAGE_VERSION = 1.1.3
XLIB_LIBXDAMAGE_SOURCE = libXdamage-$(XLIB_LIBXDAMAGE_VERSION).tar.bz2
XLIB_LIBXDAMAGE_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXDAMAGE_AUTORECONF = NO
XLIB_LIBXDAMAGE_INSTALL_STAGING = YES
XLIB_LIBXDAMAGE_BUILD_OPKG = YES
XLIB_LIBXDAMAGE_NAME_OPKG = libxdamage
XLIB_LIBXDAMAGE_SECTION = x11
XLIB_LIBXDAMAGE_DESCRIPTION = X11 damaged region extension library
XLIB_LIBXDAMAGE_OPKG_DEPENDENCIES = libx11,libxfixes
XLIB_LIBXDAMAGE_DEPENDENCIES = xproto_damageproto xlib_libX11 xlib_libXfixes xproto_xproto

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXdamage))
