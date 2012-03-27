#############################################################
#
# libogg
#
#############################################################
LIBOGG_VERSION = 1.2.2
LIBOGG_SOURCE = libogg-$(LIBOGG_VERSION).tar.gz
LIBOGG_SITE = http://downloads.xiph.org/releases/ogg
LIBOGG_AUTORECONF = NO
LIBOGG_INSTALL_STAGING = YES
LIBOGG_INSTALL_TARGET = YES
LIBOGG_BUILD_OPKG = YES

LIBOGG_SECTION = libs
LIBOGG_PRIORITY = important
LIBOGG_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBOGG_DESCRIPTION = Open source bitstream container format

LIBOGG_DEPENDENCIES = host-pkg-config

$(eval $(call AUTOTARGETS,package/multimedia,libogg))
