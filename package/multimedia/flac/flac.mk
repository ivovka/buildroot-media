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
FLAC_DEPENDENCIES = libogg
FLAC_OPKG_DEPENDENCIES = libogg

FLAC_SECTION = libs
FLAC_DESCRIPTION = An Free Lossless Audio Codec

FLAC_CONF_OPT = \
	--disable-cpplibs \
	--disable-xmms-plugin \
	--disable-rpath \
	--disable-altivec \
	--disable-doxygen-docs \
	--disable-thorough-tests \
	--disable-oggtest \
	--with-ogg=$(STAGING_DIR)/usr

define FLAC_OPKG_CLEANUP
  rm -rf $(BUILD_DIR_OPKG)/$(FLAC_BASE_NAME)/usr/bin
endef

FLAC_PRE_BUILD_OPKG_HOOKS += FLAC_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package/multimedia,flac))
