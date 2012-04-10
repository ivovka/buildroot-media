################################################################################
#
# cryptodev-linux
#
################################################################################

CRYPTODEV_LINUX_VERSION = 1.0
CRYPTODEV_LINUX_SOURCE = cryptodev-linux-$(CRYPTODEV_LINUX_VERSION).tar.gz
CRYPTODEV_LINUX_SITE = http://download.gna.org/cryptodev-linux
CRYPTODEV_LINUX_AUTORECONF = NO
CRYPTODEV_LINUX_INSTALL_STAGING = YES
CRYPTODEV_LINUX_BUILD_OPKG = YES
CRYPTODEV_LINUX_DEPENDENCIES = linux
CRYPTODEV_LINUX_OPKG_DEPENDENCIES = linux,libc
CRYPTODEV_LINUX_DESCRIPTION = device that allows access to Linux kernel cryptographic drivers
CRYPTODEV_LINUX_SECTION = driver

CRYPTODEV_LINUX_KERNEL_PATH = $(BUILD_DIR)/linux-$(LINUX_VERSION)

define CRYPTODEV_LINUX_BUILD_CMDS
  (cd $(@D); \
  $(TARGET_MAKE_ENV) $(MAKE1) $(LINUX_MAKE_FLAGS) -C $(CRYPTODEV_LINUX_KERNEL_PATH) SUBDIRS=$(@D) modules \
  )
endef

define CRYPTODEV_LINUX_INSTALL_STAGING_CMDS
  mkdir -p $(STAGING_DIR)/usr/include/crypto
  cp $(@D)/crypto/cryptodev.h $(STAGING_DIR)/usr/include/crypto
endef

define CRYPTODEV_LINUX_BUILD_OPKG_CMDS
  mkdir -p $(BUILD_DIR_OPKG)/$(CRYPTODEV_LINUX_BASE_NAME)/lib/modules/$(LINUX_VERSION)/cryptodev
  cp $(@D)/cryptodev.ko $(BUILD_DIR_OPKG)/$(CRYPTODEV_LINUX_BASE_NAME)/lib/modules/$(LINUX_VERSION)/cryptodev
endef

$(eval $(call GENTARGETS,package,cryptodev-linux))
