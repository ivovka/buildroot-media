################################################################################
#
# xapp_xrandr -- primitive command line interface to RandR extension
#
################################################################################

XAPP_XRANDR_VERSION = 1.3.5
XAPP_XRANDR_SOURCE = xrandr-$(XAPP_XRANDR_VERSION).tar.bz2
XAPP_XRANDR_SITE = http://xorg.freedesktop.org/releases/individual/app
XAPP_XRANDR_AUTORECONF = NO
XAPP_XRANDR_INSTALL_STAGING = NO
XAPP_XRANDR_DEPENDENCIES = xlib_libXrandr xlib_libX11 xutil_util-macros
XAPP_XRANDR_BUILD_OPKG = YES
XAPP_XRANDR_NAME_OPKG = xrandr
XAPP_XRANDR_SECTION = x11
XAPP_XRANDR_DESCRIPTION = A primitive command line interface to RandR extension
XAPP_XRANDR_OPKG_DEPENDENCIES = libxrandr,libx11
XAPP_XRANDR_CONF_OPT = --disable-malloc0returnsnull

$(eval $(call AUTOTARGETS,package/x11r7,xapp_xrandr))
