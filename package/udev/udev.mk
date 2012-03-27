#############################################################
#
# udev
#
#############################################################
UDEV_VERSION:=181
UDEV_SOURCE:=udev-$(UDEV_VERSION).tar.bz2
UDEV_SITE:=$(BR2_KERNEL_MIRROR)/linux/utils/kernel/hotplug/
UDEV_INSTALL_STAGING=YES
UDEV_BUILD_OPKG = YES

UDEV_SECTION = system
UDEV_PRIORITY = optional
UDEV_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
UDEV_DESCRIPTION = A Userspace Implementation for dynamic dev nodes
UDEV_OPKG_DEPENDENCIES = libglib2,pciutils,usbutils,libusb-compat,kmod

UDEV_DEPENDENCIES += libglib2 pciutils usbutils libusb-compat kmod

UDEV_CONF_ENV += \
    ac_cv_file__usr_share_pci_ids="yes" \
    ac_cv_file__usr_share_hwdata_pci_ids="no" \
    ac_cv_file__usr_share_misc_pci_ids="no" \
    LDFLAGS="$(TARGET_LDFLAGS) -I$(STAGING_DIR)/usr/include/glib-2.0"

UDEV_CONF_OPT += \
    --libexecdir=/lib/udev \
    --disable-debug \
    --disable-logging \
    --disable-rule_generator \
    --disable-hwdb \
    --disable-udev_acl \
    --enable-gudev \
    --disable-introspection \
    --disable-keymap \
    --disable-floppy \
    --disable-edd \
    --without-selinux \
    --without-systemdsystemunitdir \
    --with-firmware-path=/lib/firmware \
    --with-pci-ids-path=/usr/share/pci.ids \
    --with-usb-ids-path=/usr/share/usb.ids

$(eval $(call AUTOTARGETS,package,udev))
