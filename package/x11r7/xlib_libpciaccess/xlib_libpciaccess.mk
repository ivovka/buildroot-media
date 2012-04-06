################################################################################
#
# xlib_libpciaccess -- X.Org pciaccess library
#
################################################################################

XLIB_LIBPCIACCESS_VERSION = 0.13
XLIB_LIBPCIACCESS_SOURCE = libpciaccess-$(XLIB_LIBPCIACCESS_VERSION).tar.bz2
XLIB_LIBPCIACCESS_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBPCIACCESS_INSTALL_STAGING = YES
XLIB_LIBPCIACCESS_BUILD_OPKG = YES

XLIB_LIBPCIACCESS_SECTION = x11
XLIB_LIBPCIACCESS_DESCRIPTION = X.org libpciaccess library
XLIB_LIBPCIACCESS_NAME_OPKG = libpciaccess

XLIB_LIBPCIACCESS_DEPENDENCIES = zlib xutil_util-macros
XLIB_LIBPCIACCESS_OPKG_DEPENDENCIES = zlib
XLIB_LIBPCIACCESS_CONF_ENV = ac_cv_header_asm_mtrr_h=set
XLIB_LIBPCIACCESS_CONF_OPT = \
	    --with-pciids-path=/usr/share \
	    --with-zlib

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libpciaccess))
