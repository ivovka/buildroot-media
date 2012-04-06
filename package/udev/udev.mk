#############################################################
#
# udev
#
#############################################################
UDEV_VERSION:=182
UDEV_SOURCE:=udev-$(UDEV_VERSION).tar.bz2
UDEV_SITE:=$(BR2_KERNEL_MIRROR)/linux/utils/kernel/hotplug/
UDEV_INSTALL_STAGING=YES
UDEV_BUILD_OPKG = YES
UDEV_DEPENDENCIES += libglib2 pciutils usbutils libusb-compat util-linux kmod
UDEV_OPKG_DEPENDENCIES = libglib2,pciutils,usbutils,libusb-compat,kmod,util-linux

UDEV_SECTION = system
UDEV_DESCRIPTION = A Userspace Implementation for dynamic dev nodes

UDEV_CONF_ENV += \
    ac_cv_file__usr_share_pci_ids="yes" \
    ac_cv_file__usr_share_hwdata_pci_ids="no" \
    ac_cv_file__usr_share_misc_pci_ids="no" \
    LDFLAGS="$(TARGET_LDFLAGS) -I$(STAGING_DIR)/usr/include/glib-2.0"

UDEV_CONF_OPT += \
    --libexecdir=/lib \
    --with-firmware-path=/lib/firmware \
    --disable-manpages \
    --disable-debug \
    --disable-logging \
    --disable-rule_generator \
    --enable-gudev \
    --disable-introspection \
    --disable-keymap \
    --disable-floppy \
    --without-selinux \
    --without-systemdsystemunitdir \
    --with-pci-ids-path=/usr/share/pci.ids.gz \
    --with-usb-ids-path=/usr/share/usb.ids.gz

define UDEV_OPKG_CLEANUP
  rm -rf $(BUILD_DIR_OPKG)/$(UDEV_BASE_NAME)/usr/share
endef

UDEV_PRE_BUILD_OPKG_HOOKS += UDEV_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package,udev))
