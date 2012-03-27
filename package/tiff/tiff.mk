#############################################################
#
# tiff
#
#############################################################
TIFF_VERSION:=4.0.0beta7
TIFF_SITE:=ftp://ftp.remotesensing.org/pub/libtiff
TIFF_SOURCE:=tiff-$(TIFF_VERSION).tar.gz
TIFF_INSTALL_STAGING = YES
TIFF_INSTALL_TARGET = YES
TIFF_BUILD_OPKG = YES

TIFF_SECTION = graphics
TIFF_PRIORITY = optional
TIFF_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
TIFF_DESCRIPTION = A library for reading and writing TIFF files
TIFF_CONF_OPT = \
	--disable-mdi \
	--enable-cxx \
	--without-x \

TIFF_DEPENDENCIES = host-pkg-config zlib $(call qstrip,$(BR2_JPEG_LIBRARY))
TIFF_OPKG_DEPENDENCIES = $(call qstrip,$(BR2_JPEG_LIBRARY))

define TIFF_INSTALL_TARGET_CMDS
	-cp -a $(@D)/libtiff/.libs/libtiff.so* $(TARGET_DIR)/usr/lib/
	-cp -a $(@D)/libtiff/.libs/libtiffxx.so* $(TARGET_DIR)/usr/lib/
	rm -rf $(TARGET_DIR)/usr/lib/libtiffxx.so*T
endef

define TIFF_BUILD_OPKG_CMDS
	mkdir -p $(BUILD_DIR_OPKG)/tiff-$(TIFF_VERSION)/usr/lib
	-cp -a $(@D)/libtiff/.libs/libtiff.so* $(BUILD_DIR_OPKG)/tiff-$(TIFF_VERSION)/usr/lib/
	-cp -a $(@D)/libtiff/.libs/libtiffxx.so* $(BUILD_DIR_OPKG)/tiff-$(TIFF_VERSION)/usr/lib/
	rm -rf $(BUILD_DIR_OPKG)/tiff-$(TIFF_VERSION)/usr/lib/libtiffxx.so*T
endef

$(eval $(call AUTOTARGETS,package,tiff))
