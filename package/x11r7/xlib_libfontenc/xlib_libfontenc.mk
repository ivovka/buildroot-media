################################################################################
#
# xlib_libfontenc -- X.Org fontenc library
#
################################################################################

XLIB_LIBFONTENC_VERSION = 1.1.1
XLIB_LIBFONTENC_SOURCE = libfontenc-$(XLIB_LIBFONTENC_VERSION).tar.bz2
XLIB_LIBFONTENC_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBFONTENC_AUTORECONF = NO
XLIB_LIBFONTENC_INSTALL_STAGING = YES
XLIB_LIBFONTENC_DEPENDENCIES = zlib xproto_xproto xutil_util-macros
XLIB_LIBFONTENC_BUILD_OPKG = NO 
XLIB_LIBFONTENC_NAME_OPKG = libfontenc
XLIB_LIBFONTENC_SECTION = x11
XLIB_LIBFONTENC_DESCRIPTION = X11 font encoding library

HOST_XLIB_LIBFONTENC_DEPENDENCIES = host-zlib host-xproto_xproto

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libfontenc))
$(eval $(call AUTOTARGETS,package/x11r7,xlib_libfontenc,host))
