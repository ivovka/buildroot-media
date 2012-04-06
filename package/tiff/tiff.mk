#############################################################
#
# tiff
#
#############################################################
TIFF_VERSION:=4.0.1
TIFF_SITE:=ftp://ftp.remotesensing.org/pub/libtiff
TIFF_SOURCE:=tiff-$(TIFF_VERSION).tar.gz
TIFF_INSTALL_STAGING = YES
TIFF_INSTALL_TARGET = YES
TIFF_BUILD_OPKG = YES
TIFF_DEPENDENCIES = host-pkg-config zlib $(call qstrip,$(BR2_JPEG_LIBRARY))
TIFF_OPKG_DEPENDENCIES = zlib,$(call qstrip,$(BR2_JPEG_LIBRARY))

TIFF_SECTION = graphics
TIFF_DESCRIPTION = A library for reading and writing TIFF files
TIFF_CONF_OPT = \
	--disable-mdi \
	--enable-cxx \
	--without-x \

define TIFF_INSTALL_TARGET_CMDS
	-cp -a $(@D)/libtiff/.libs/libtiff.so* $(TARGET_DIR)/usr/lib/
	-cp -a $(@D)/libtiff/.libs/libtiffxx.so* $(TARGET_DIR)/usr/lib/
	rm -rf $(TARGET_DIR)/usr/lib/libtiffxx.so*T
endef

define TIFF_BUILD_OPKG_CMDS
	mkdir -p $(BUILD_DIR_OPKG)/$(TIFF_BASE_NAME)/usr/lib
	-cp -a $(@D)/libtiff/.libs/libtiff.so* $(BUILD_DIR_OPKG)/$(TIFF_BASE_NAME)/usr/lib/
	-cp -a $(@D)/libtiff/.libs/libtiffxx.so* $(BUILD_DIR_OPKG)/$(TIFF_BASE_NAME)/usr/lib/
	rm -rf $(BUILD_DIR_OPKG)/$(TIFF_BASE_NAME)/usr/lib/libtiffxx.so*T
endef

$(eval $(call AUTOTARGETS,package,tiff))
