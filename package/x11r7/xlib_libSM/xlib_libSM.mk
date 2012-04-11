################################################################################
#
# xlib_libSM -- X.Org SM library
#
################################################################################

XLIB_LIBSM_VERSION = 1.2.1
XLIB_LIBSM_SOURCE = libSM-$(XLIB_LIBSM_VERSION).tar.bz2
XLIB_LIBSM_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBSM_AUTORECONF = NO
XLIB_LIBSM_INSTALL_STAGING = YES
XLIB_LIBSM_BUILD_OPKG = YES

XLIB_LIBSM_NAME_OPKG = libsm
XLIB_LIBSM_SECTION = x11
XLIB_LIBSM_DESCRIPTION = X11 Inter-Client Exchange library
XLIB_LIBSM_OPKG_DEPENDENCIES = util-linux,libice

XLIB_LIBSM_DEPENDENCIES = xlib_libICE util-linux xutil_util-macros
XLIB_LIBSM_CONF_OPT = --with-libuuid --without-xmlto --without-fop

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libSM))
