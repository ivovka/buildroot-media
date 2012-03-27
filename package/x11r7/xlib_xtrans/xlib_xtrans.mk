################################################################################
#
# xlib_xtrans -- X.Org xtrans library
#
################################################################################

XLIB_XTRANS_VERSION = 1.2.6
XLIB_XTRANS_SOURCE = xtrans-$(XLIB_XTRANS_VERSION).tar.bz2
XLIB_XTRANS_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_XTRANS_AUTORECONF = NO
XLIB_XTRANS_INSTALL_STAGING = YES
XLIB_XTRANS_BUILD_OPKG = YES

XLIB_XTRANS_DEPENDENCIES = xutil_util-macros
XLIB_XTRANS_NAME_OPKG = xtrans
XLIB_XTRANS_SECTION = x11
XLIB_XTRANS_DESCRIPTION = Abstract network code for X

$(eval $(call AUTOTARGETS,package/x11r7,xlib_xtrans))
$(eval $(call AUTOTARGETS,package/x11r7,xlib_xtrans,host))
