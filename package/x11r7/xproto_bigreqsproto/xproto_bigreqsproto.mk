################################################################################
#
# xproto_bigreqsproto -- X.Org BigReqs protocol headers
#
################################################################################

XPROTO_BIGREQSPROTO_VERSION = 1.1.2
XPROTO_BIGREQSPROTO_SOURCE = bigreqsproto-$(XPROTO_BIGREQSPROTO_VERSION).tar.bz2
XPROTO_BIGREQSPROTO_SITE = http://xorg.freedesktop.org/releases/individual/proto
XPROTO_BIGREQSPROTO_AUTORECONF = NO
XPROTO_BIGREQSPROTO_INSTALL_STAGING = YES
XPROTO_BIGREQSPROTO_INSTALL_TARGET = NO
XPROTO_BIGREQSPROTO_DEPENDENCIES = xutil_util-macros

$(eval $(call AUTOTARGETS,package/x11r7,xproto_bigreqsproto))
