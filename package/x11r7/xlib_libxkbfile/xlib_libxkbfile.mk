################################################################################
#
# xlib_libxkbfile -- X.Org xkbfile library
#
################################################################################

XLIB_LIBXKBFILE_VERSION = 1.0.8
XLIB_LIBXKBFILE_SOURCE = libxkbfile-$(XLIB_LIBXKBFILE_VERSION).tar.bz2
XLIB_LIBXKBFILE_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXKBFILE_AUTORECONF = NO
XLIB_LIBXKBFILE_INSTALL_STAGING = YES
XLIB_LIBXKBFILE_BUILD_OPKG = YES
XLIB_LIBXKBFILE_NAME_OPKG = libxkbfile
XLIB_LIBXKBFILE_SECTION = x11
XLIB_LIBXKBFILE_DESCRIPTION = X11 keyboard file manipulation library
XLIB_LIBXKBFILE_OPKG_DEPENDENCIES = libx11
XLIB_LIBXKBFILE_DEPENDENCIES = xlib_libX11 xproto_kbproto xutil_util-macros

HOST_XLIB_LIBXKBFILE_DEPENDENCIES = host-xlib_libX11 host-xproto_kbproto host-xutil_util-macros

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libxkbfile))
$(eval $(call AUTOTARGETS,package/x11r7,xlib_libxkbfile,host))
