################################################################################
#
# xapp_xkbcomp -- compile XKB keyboard description
#
################################################################################

XAPP_XKBCOMP_VERSION = 1.2.4
XAPP_XKBCOMP_SOURCE = xkbcomp-$(XAPP_XKBCOMP_VERSION).tar.bz2
XAPP_XKBCOMP_SITE = http://xorg.freedesktop.org/releases/individual/app
XAPP_XKBCOMP_AUTORECONF = NO
XAPP_XKBCOMP_DEPENDENCIES = xutil_util-macros xlib_libX11 xlib_libxkbfile
HOST_XAPP_XKBCOMP_DEPENDENCIES = host-xlib_libX11 host-xlib_libxkbfile
XAPP_XKBCOMP_INSTALL_STAGING = NO
XAPP_XKBCOMP_BUILD_OPKG = YES
XAPP_XKBCOMP_NAME_OPKG = xkbcomp
XAPP_XKBCOMP_SECTION = x11
XAPP_XKBCOMP_DESCRIPTION = Compiles XKB keyboard description
XAPP_XKBCOMP_OPKG_DEPENDENCIES = libx11,libxkbfile

XAPP_XKBCOMP_CONF_ENV += ac_cv_file__xkbparse_c=yes

$(eval $(call AUTOTARGETS,package/x11r7,xapp_xkbcomp))
$(eval $(call AUTOTARGETS,package/x11r7,xapp_xkbcomp,host))
