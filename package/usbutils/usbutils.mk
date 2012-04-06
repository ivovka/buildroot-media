#############################################################
#
# usbutils
#
#############################################################

USBUTILS_VERSION = 004
USBUTILS_SITE = http://www.mirrorservice.org/sites/ftp.kernel.org/pub/linux/utils/usb/usbutils
USBUTILS_INSTALL_STAGING = YES
USBUTILS_BUILD_OPKG = YES
USBUTILS_DEPENDENCIES = host-pkg-config libusb libusb-compat
USBUTILS_OPKG_DEPENDENCIES = libusb-compat

USBUTILS_SECTION = system
USBUTILS_DESCRIPTION = Linux USB Utilities

ifeq ($(BR2_PACKAGE_USBUTILS_ZLIB),y)
	USBUTILS_DEPENDENCIES += zlib
	USBUTILS_OPKG_DEPENDENCIES += ,zlib
else
	USBUTILS_CONF_OPT = --disable-zlib
endif

define USBUTILS_TARGET_CLEANUP
	rm -f $(TARGET_DIR)/usr/bin/usb-devices
	rm -f $(TARGET_DIR)/usr/sbin/update-usbids.sh
	rm -f $(TARGET_DIR)/usr/share/pkgconfig/usbutils.pc
endef

define USBUTILS_OPKG_CLEANUP
	rm -f $(BUILD_DIR_OPKG)/$(USBUTILS_BASE_NAME)/usr/bin/{lsusb.py,usb-devices,usbhid-dump}
	rm -rf $(BUILD_DIR_OPKG)/$(USBUTILS_BASE_NAME)/usr/sbin
	rm -rf $(BUILD_DIR_OPKG)/$(USBUTILS_BASE_NAME)/usr/share/pkgconfig
endef

USBUTILS_POST_INSTALL_TARGET_HOOKS += USBUTILS_TARGET_CLEANUP
USBUTILS_PRE_BUILD_OPKG_HOOKS += USBUTILS_OPKG_CLEANUP

ifeq ($(BR2_PACKAGE_USBUTILS_ZLIB),y)
define USBUTILS_RM_IDS
	rm -f $(1)/usr/share/usb.ids
endef
else
define USBUTILS_RM_IDS
	rm -f $(1)/usr/share/usb.ids.gz
endef
endif

define USBUTILS_RM_IDS_TARGET
  $(call USBUTILS_RM_IDS,$(TARGET_DIR))
endef

define USBUTILS_RM_IDS_OPKG
  $(call USBUTILS_RM_IDS,$(BUILD_DIR_OPKG)/$(USBUTILS_BASE_NAME))
endef

USBUTILS_POST_INSTALL_TARGET_HOOKS += USBUTILS_RM_IDS_TARGET
USBUTILS_PRE_BUILD_OPKG_HOOKS += USBUTILS_RM_IDS_OPKG

define USBUTILS_REMOVE_DEVFILES
	rm -f $(TARGET_DIR)/usr/bin/libusb-config
endef

ifneq ($(BR2_HAVE_DEVFILES),y)
USBUTILS_POST_INSTALL_TARGET_HOOKS += USBUTILS_REMOVE_DEVFILES
endif

$(eval $(call AUTOTARGETS,package,usbutils))
