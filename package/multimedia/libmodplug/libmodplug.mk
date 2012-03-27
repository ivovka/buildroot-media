#############################################################
#
# libmodplug
#
#############################################################

LIBMODPLUG_VERSION = 0.8.8.1
LIBMODPLUG_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/modplug-xmms/libmodplug/$(LIBMODPLUG_VERSION)
LIBMODPLUG_SOURCE = libmodplug-$(LIBMODPLUG_VERSION).tar.gz
LIBMODPLUG_INSTALL_STAGING = YES
LIBMODPLUG_INSTALL_TARGET = YES
LIBMODPLUG_BUILD_OPKG = YES

LIBMODPLUG_SECTION = libs
LIBMODPLUG_PRIORITY = optional
LIBMODPLUG_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBMODPLUG_DESCRIPTION = renders mod music files as raw audio data, for playing or conversion.


$(eval $(call AUTOTARGETS,package/multimedia,libmodplug))
