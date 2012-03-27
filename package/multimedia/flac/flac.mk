################################################################################
#
# flac
#
################################################################################

FLAC_VERSION = 1.2.1
FLAC_SOURCE = flac-$(FLAC_VERSION).tar.gz
FLAC_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/flac/
FLAC_INSTALL_STAGING = YES
FLAC_BUILD_OPKG = YES
FLAC_AUTORECONF = YES

FLAC_SECTION = libs
FLAC_PRIORITY = optional
FLAC_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
FLAC_DESCRIPTION = An Free Lossless Audio Codec

FLAC_CONF_OPT = \
	--disable-cpplibs \
	--disable-xmms-plugin \
	--disable-rpath \
	--disable-altivec \
	--disable-doxygen-docs \
	--disable-thorough-tests \
	--disable-oggtest \
	--with-libiconv-prefix="$(STAGING_DIR)/usr"

ifeq ($(BR2_PACKAGE_LIBOGG),y)
FLAC_CONF_OPT += --with-ogg=$(STAGING_DIR)/usr
FLAC_DEPENDENCIES = libogg
FLAC_OPKG_DEPENDENCIES = libogg
else
FLAC_CONF_OPT += --disable-ogg
endif

$(eval $(call AUTOTARGETS,package/multimedia,flac))
