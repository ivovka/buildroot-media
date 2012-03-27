#############################################################
#
# libmms
#
#############################################################
LIBMMS_VERSION = 0.6.2
LIBMMS_SOURCE = libmms-$(LIBMMS_VERSION).tar.gz
LIBMMS_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/libmms

LIBMMS_AUTORECONF = NO
LIBMMS_INSTALL_STAGING = YES
LIBMMS_INSTALL_TARGET = YES
LIBMMS_BUILD_OPKG = YES
LIBMMS_SECTION = multimedia
LIBMMS_DESCRIPTION = A common library for parsing mms: and mmsh: type network streams.
LIBMMS_OPKG_DEPENDENCIES = libglib2

LIBMMS_DEPENDENCIES = host-pkg-config libglib2

$(eval $(call AUTOTARGETS,package/multimedia,libmms))
