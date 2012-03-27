#############################################################
#
# usbutils
#
#############################################################

USBUTILS_VERSION = 004
USBUTILS_SITE = http://www.mirrorservice.org/sites/ftp.kernel.org/pub/linux/utils/usb/usbutils
USBUTILS_DEPENDENCIES = host-pkg-config libusb libusb-compat
USBUTILS_INSTALL_STAGING = YES
USBUTILS_BUILD_OPKG = YES

USBUTILS_SECTION = system
USBUTILS_PRIORITY = optional
USBUTILS_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
USBUTILS_DESCRIPTION = Linux USB Utilities
USBUTILS_OPKG_DEPENDENCIES = libusb-compat,zlib

ifeq ($(BR2_PACKAGE_USBUTILS_ZLIB),y)
	USBUTILS_DEPENDENCIES += zlib
else
	USBUTILS_CONF_OPT = --disable-zlib
endif

define USBUTILS_TARGET_CLEANUP
	rm -f $(TARGET_DIR)/usr/bin/usb-devices
	rm -f $(TARGET_DIR)/usr/sbin/update-usbids.sh
	rm -f $(TARGET_DIR)/usr/share/pkgconfig/usbutils.pc
endef

USBUTILS_POST_INSTALL_TARGET_HOOKS += USBUTILS_TARGET_CLEANUP

define USBUTILS_REMOVE_UNCOMPRESSED_IDS
	rm -f $(TARGET_DIR)/usr/share/usb.ids
endef

define USBUTILS_REMOVE_COMPRESSED_IDS
	rm -f $(TARGET_DIR)/usr/share/usb.ids.gz
endef

ifeq ($(BR2_PACKAGE_USBUTILS_ZLIB),y)
USBUTILS_POST_INSTALL_TARGET_HOOKS += USBUTILS_REMOVE_UNCOMPRESSED_IDS
else
USBUTILS_POST_INSTALL_TARGET_HOOKS += USBUTILS_REMOVE_COMPRESSED_IDS
endif

define USBUTILS_REMOVE_DEVFILES
	rm -f $(TARGET_DIR)/usr/bin/libusb-config
endef

define USBUTILS_COPY_IDS
	mkdir -p $(BUILD_DIR_OPKG)/usbutils-$(USBUTILS_VERSION)/usr/share
	cp $(TOPDIR)/package/usbutils/usb.ids $(BUILD_DIR_OPKG)/usbutils-$(USBUTILS_VERSION)/usr/share
	rm -rf $(BUILD_DIR_OPKG)/usbutils-$(USBUTILS_VERSION)/usr/share/pkgconfig
endef

USBUTILS_PRE_BUILD_OPKG_HOOKS += USBUTILS_COPY_IDS

ifneq ($(BR2_HAVE_DEVFILES),y)
USBUTILS_POST_INSTALL_TARGET_HOOKS += USBUTILS_REMOVE_DEVFILES
endif

$(eval $(call AUTOTARGETS,package,usbutils))
