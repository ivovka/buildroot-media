#############################################################
#
# kmod
#
#############################################################
KMOD_VERSION = 7
KMOD_SOURCE = kmod-$(KMOD_VERSION).tar.xz
KMOD_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/kernel/kmod/
KMOD_INSTALL_STAGING = YES
KMOD_BUILD_OPKG = YES

KMOD_SECTION = system
KMOD_DESCRIPTION = The new module loader
KMOD_OPKG_DEPENDENCIES = libc
KMOD_CONF_OPT = \
	--enable-tools \
	--enable-logging \
	--without-xz \
	--without-zlib

define KMOD_OPKG_TOOLS
  mkdir -p $(BUILD_DIR_OPKG)/$(KMOD_BASE_NAME)/sbin
  ln -sf /usr/bin/kmod $(BUILD_DIR_OPKG)/$(KMOD_BASE_NAME)/sbin/lsmod
  ln -sf /usr/bin/kmod $(BUILD_DIR_OPKG)/$(KMOD_BASE_NAME)/sbin/insmod
  ln -sf /usr/bin/kmod $(BUILD_DIR_OPKG)/$(KMOD_BASE_NAME)/sbin/rmmod
  ln -sf /usr/bin/kmod $(BUILD_DIR_OPKG)/$(KMOD_BASE_NAME)/sbin/modinfo
  ln -sf /usr/bin/kmod $(BUILD_DIR_OPKG)/$(KMOD_BASE_NAME)/sbin/modprobe
endef

KMOD_PRE_BUILD_OPKG_HOOKS += KMOD_OPKG_TOOLS
$(eval $(call AUTOTARGETS,package,kmod))
