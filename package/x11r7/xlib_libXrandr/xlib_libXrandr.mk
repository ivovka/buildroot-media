################################################################################
#
# xlib_libXrandr -- X.Org Xrandr library
#
################################################################################

XLIB_LIBXRANDR_VERSION = 1.3.2
XLIB_LIBXRANDR_SOURCE = libXrandr-$(XLIB_LIBXRANDR_VERSION).tar.bz2
XLIB_LIBXRANDR_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXRANDR_AUTORECONF = NO
XLIB_LIBXRANDR_INSTALL_STAGING = YES
XLIB_LIBXRANDR_DEPENDENCIES = xproto_randrproto xlib_libX11 xlib_libXext xlib_libXrender xproto_renderproto xproto_xproto
XLIB_LIBXRANDR_CONF_OPT = --enable-malloc0returnsnull
XLIB_LIBXRANDR_BUILD_OPKG = YES
XLIB_LIBXRANDR_NAME_OPKG = libxrandr
XLIB_LIBXRANDR_SECTION = x11
XLIB_LIBXRANDR_DESCRIPTION = X Resize, Rotate and Reflection extension client library
XLIB_LIBXRANDR_OPKG_DEPENDENCIES = libx11,libxext,libxrender

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXrandr))
