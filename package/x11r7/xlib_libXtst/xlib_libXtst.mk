################################################################################
#
# xlib_libXtst -- X.Org Xtst library
#
################################################################################

XLIB_LIBXTST_VERSION = 1.2.1
XLIB_LIBXTST_SOURCE = libXtst-$(XLIB_LIBXTST_VERSION).tar.bz2
XLIB_LIBXTST_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXTST_INSTALL_STAGING = YES
XLIB_LIBXTST_BUILD_OPKG = YES
XLIB_LIBXTST_NAME_OPKG = libxtst
XLIB_LIBXTST_SECTION = x11
XLIB_LIBXTST_DESCRIPTION = The Xtst Library
XLIB_LIBXTST_OPKG_DEPENDENCIES = libxext,libxi,libx11

XLIB_LIBXTST_DEPENDENCIES = \
	xutil_util-macros \
	xlib_libX11 \
	xlib_libXext \
	xlib_libXi \
	xproto_recordproto \
	xproto_xextproto \
	xproto_inputproto

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXtst))
