################################################################################
#
# xapp_setxkbmap -- Controls the keyboard layout of a running X server.
#
################################################################################

XAPP_SETXKBMAP_VERSION = 1.2.0
XAPP_SETXKBMAP_SOURCE = setxkbmap-$(XAPP_SETXKBMAP_VERSION).tar.bz2
XAPP_SETXKBMAP_SITE = http://xorg.freedesktop.org/releases/individual/app
XAPP_SETXKBMAP_AUTORECONF = NO
XAPP_SETXKBMAP_DEPENDENCIES = xlib_libX11 xlib_libxkbfile
XAPP_SETXKBMAP_BUILD_OPKG = YES
XAPP_SETXKBMAP_NAME_OPKG = setxkbmap
XAPP_SETXKBMAP_SECTION = x11
XAPP_SETXKBMAP_DESCRIPTION = Sets the keyboard using the X Keyboard Extension
XAPP_SETXKBMAP_OPKG_DEPENDENCIES = libx11,libxkbfile

$(eval $(call AUTOTARGETS,package/x11r7,xapp_setxkbmap))
