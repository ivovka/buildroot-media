################################################################################
#
# xlib_libXxf86vm -- X.Org Xxf86vm library
#
################################################################################

XLIB_LIBXXF86VM_VERSION = 1.1.2
XLIB_LIBXXF86VM_SOURCE = libXxf86vm-$(XLIB_LIBXXF86VM_VERSION).tar.bz2
XLIB_LIBXXF86VM_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXXF86VM_AUTORECONF = NO
XLIB_LIBXXF86VM_INSTALL_STAGING = YES
XLIB_LIBXXF86VM_BUILD_OPKG = YES
XLIB_LIBXXF86VM_NAME_OPKG = libxxf86vm
XLIB_LIBXXF86VM_SECTION = x11
XLIB_LIBXXF86VM_DESCRIPTION = Extension library for the XFree86-VidMode X extension
XLIB_LIBXXF86VM_OPKG_DEPENDENCIES = libx11,libxext
XLIB_LIBXXF86VM_DEPENDENCIES = xlib_libX11 xlib_libXext xproto_xf86vidmodeproto xutil_util-macros
XLIB_LIBXXF86VM_CONF_OPT = --enable-malloc0returnsnull

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXxf86vm))
