################################################################################
#
# xlib_libXfont -- X.Org Xfont library
#
################################################################################

XLIB_LIBXFONT_VERSION = 1.4.5
XLIB_LIBXFONT_SOURCE = libXfont-$(XLIB_LIBXFONT_VERSION).tar.bz2
XLIB_LIBXFONT_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXFONT_AUTORECONF = YES
XLIB_LIBXFONT_INSTALL_STAGING = YES
XLIB_LIBXFONT_BUILD_OPKG = YES
XLIB_LIBXFONT_NAME_OPKG = libxfont
XLIB_LIBXFONT_SECTION = x11
XLIB_LIBXFONT_DESCRIPTION = X font Library
XLIB_LIBXFONT_OPKG_DEPENDENCIES = freetype,libfontenc,xtrans
XLIB_LIBXFONT_DEPENDENCIES = freetype xlib_libfontenc xlib_xtrans xproto_fontcacheproto xproto_fontsproto
XLIB_LIBXFONT_CONF_OPT = --disable-devel-docs \
	--enable-freetype \
	--enable-builtins \
	--disable-pcfformat \
	--disable-bdfformat \
	--disable-snfformat \
	--enable-fc

HOST_XLIB_LIBXFONT_CONF_OPT = --disable-devel-docs
HOST_XLIB_LIBXFONT_DEPENDENCIES = host-freetype host-xlib_libfontenc host-xlib_xtrans host-xproto_fontcacheproto host-xproto_fontsproto host-xproto_xproto host-xfont_encodings

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXfont))
$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXfont,host))
