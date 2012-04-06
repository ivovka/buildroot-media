#############################################################
#
# libvorbis
#
#############################################################

LIBVORBIS_VERSION = 1.3.3
LIBVORBIS_SOURCE = libvorbis-$(LIBVORBIS_VERSION).tar.gz
LIBVORBIS_SITE = http://downloads.xiph.org/releases/vorbis/$(LIBVORBIS-SOURCE)
LIBVORBIS_AUTORECONF = YES
LIBVORBIS_INSTALL_STAGING = YES
LIBVORBIS_INSTALL_TARGET = YES
LIBVORBIS_BUILD_OPKG = YES
LIBVORBIS_DEPENDENCIES = host-pkg-config libogg
LIBVORBIS_OPKG_DEPENDENCIES = libogg

LIBVORBIS_SECTION = libs
LIBVORBIS_DESCRIPTION = Lossless audio compression tools using the ogg-vorbis algorithms

LIBVORBIS_CONF_OPT = --with-ogg=$(STAGING_DIR)/usr

$(eval $(call AUTOTARGETS,package/multimedia,libvorbis))
