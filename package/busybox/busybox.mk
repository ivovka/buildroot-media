#############################################################
#
# busybox
#
#############################################################

ifeq ($(BR2_PACKAGE_BUSYBOX_SNAPSHOT),y)
BUSYBOX_VERSION = snapshot
BUSYBOX_SITE = http://www.busybox.net/downloads/snapshots
else
BUSYBOX_VERSION = $(call qstrip,$(BR2_BUSYBOX_VERSION))
BUSYBOX_SITE = http://www.busybox.net/downloads
endif
BUSYBOX_SOURCE = busybox-$(BUSYBOX_VERSION).tar.bz2
BUSYBOX_BUILD_CONFIG = $(BUSYBOX_DIR)/.config

BUSYBOX_BUILD_OPKG = YES
BUSYBOX_SECTION = system
BUSYBOX_PRIORITY = required
BUSYBOX_DESCRIPTION = Swiss army knife

# Allows the build system to tweak CFLAGS
BUSYBOX_MAKE_ENV = $(TARGET_MAKE_ENV) CFLAGS="$(TARGET_CFLAGS) -I$(LINUX_HEADERS_DIR)/include"
BUSYBOX_MAKE_OPTS_CMN = \
	CC="$(TARGET_CC)" \
	ARCH=$(KERNEL_ARCH) \
	EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	SKIP_STRIP=y

BUSYBOX_MAKE_OPTS = $(BUSYBOX_MAKE_OPTS_CMN) PREFIX="$(TARGET_DIR)" CONFIG_PREFIX="$(TARGET_DIR)"
BUSYBOX_MAKE_OPTS_OPKG = $(BUSYBOX_MAKE_OPTS_CMN) PREFIX="$(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)" CONFIG_PREFIX="$(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)"

ifndef BUSYBOX_CONFIG_FILE
	BUSYBOX_CONFIG_FILE = $(call qstrip,$(BR2_PACKAGE_BUSYBOX_CONFIG))
endif

# If mdev will be used for device creation enable it and copy S10mdev to /etc/init.d
ifeq ($(BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_MDEV),y)
define BUSYBOX_INSTALL_MDEV_SCRIPT
	install -m 0755 package/busybox/S10mdev $(TARGET_DIR)/etc/init.d
endef
define BUSYBOX_INSTALL_MDEV_SCRIPT_OPKG
	install -m 0755 package/busybox/S10mdev $(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)/etc/init.d
define BUSYBOX_INSTALL_MDEV_CONF
	[ -f $(TARGET_DIR)/etc/mdev.conf ] || \
		install -D -m 0644 package/busybox/mdev.conf \
			$(TARGET_DIR)/etc/mdev.conf
endef
define BUSYBOX_INSTALL_MDEV_CONF_OPKG
	[ -f $(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)/etc/mdev.conf ] || \
		install -D -m 0644 package/busybox/mdev.conf \
			$(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)/etc/mdev.conf
endef
define BUSYBOX_SET_MDEV
define BUSYBOX_SET_MDEV
	$(call KCONFIG_ENABLE_OPT,CONFIG_MDEV,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_MDEV_CONF,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_MDEV_EXEC,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_MDEV_LOAD_FIRMWARE,$(BUSYBOX_BUILD_CONFIG))
endef
endif

ifeq ($(BR2_LARGEFILE),y)
define BUSYBOX_SET_LARGEFILE
	$(call KCONFIG_ENABLE_OPT,CONFIG_LFS,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_ENABLE_OPT,CONFIG_FDISK_SUPPORT_LARGE_DISKS,$(BUSYBOX_BUILD_CONFIG))
endef
else
define BUSYBOX_SET_LARGEFILE
	$(call KCONFIG_DISABLE_OPT,CONFIG_LFS,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_DISABLE_OPT,CONFIG_FDISK_SUPPORT_LARGE_DISKS,$(BUSYBOX_BUILD_CONFIG))
endef
endif

# If IPv6 is enabled then enable basic ifupdown support for it
ifeq ($(BR2_INET_IPV6),y)
define BUSYBOX_SET_IPV6
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_IPV6,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_IFUPDOWN_IPV6,$(BUSYBOX_BUILD_CONFIG))
endef
else
define BUSYBOX_SET_IPV6
	$(call KCONFIG_DISABLE_OPT,CONFIG_FEATURE_IPV6,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_DISABLE_OPT,CONFIG_FEATURE_IFUPDOWN_IPV6,$(BUSYBOX_BUILD_CONFIG))
endef
endif

# If RPC is enabled then enable nfs mounts
ifeq ($(BR2_INET_RPC),y)
define BUSYBOX_SET_RPC
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_MOUNT_NFS,$(BUSYBOX_BUILD_CONFIG))
endef
else
define BUSYBOX_SET_RPC
	$(call KCONFIG_DISABLE_OPT,CONFIG_FEATURE_MOUNT_NFS,$(BUSYBOX_BUILD_CONFIG))
endef
endif

# If we're using static libs do the same for busybox
ifeq ($(BR2_PREFER_STATIC_LIB),y)
define BUSYBOX_PREFER_STATIC
	$(call KCONFIG_ENABLE_OPT,CONFIG_STATIC,$(BUSYBOX_BUILD_CONFIG))
endef
else
define BUSYBOX_PREFER_STATIC
	$(call KCONFIG_DISABLE_OPT,CONFIG_STATIC,$(BUSYBOX_BUILD_CONFIG))
endef
endif

# Disable usage of inetd if netkit-base package is selected
ifeq ($(BR2_PACKAGE_NETKITBASE),y)
define BUSYBOX_NETKITBASE
	$(call KCONFIG_DISABLE_OPT,CONFIG_INETD,$(BUSYBOX_BUILD_CONFIG))
endef
endif

# Disable usage of telnetd if netkit-telnetd package is selected
ifeq ($(BR2_PACKAGE_NETKITTELNET),y)
define BUSYBOX_NETKITTELNET
	$(call KCONFIG_DISABLE_OPT,CONFIG_TELNETD,$(BUSYBOX_BUILD_CONFIG))
endef
endif

define BUSYBOX_COPY_CONFIG
	cp -f $(BUSYBOX_CONFIG_FILE) $(BUSYBOX_BUILD_CONFIG)
endef

# Disable shadow passwords support if unsupported by the C library
ifeq ($(BR2_TOOLCHAIN_HAS_SHADOW_PASSWORDS),)
define BUSYBOX_INTERNAL_SHADOW_PASSWORDS
	$(call KCONFIG_ENABLE_OPT,CONFIG_USE_BB_PWD_GRP,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_ENABLE_OPT,CONFIG_USE_BB_SHADOW,$(BUSYBOX_BUILD_CONFIG))
endef
endif

ifeq ($(BR2_USE_MMU),)
define BUSYBOX_DISABLE_MMU_APPLETS
	$(call KCONFIG_DISABLE_OPT,CONFIG_SWAPONOFF,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_DISABLE_OPT,CONFIG_ASH,$(BUSYBOX_BUILD_CONFIG))
	$(call KCONFIG_ENABLE_OPT,CONFIG_HUSH,$(BUSYBOX_BUILD_CONFIG))
endef
endif

define BUSYBOX_INSTALL_LOGGING_SCRIPT
	if grep -q CONFIG_SYSLOGD=y $(@D)/.config; then \
		$(INSTALL) -m 0755 -D package/busybox/S08logging \
			$(TARGET_DIR)/etc/init.d/S08logging; \
	else rm -f $(TARGET_DIR)/etc/init.d/S08logging; fi
endef

define BUSYBOX_INSTALL_LOGGING_SCRIPT_OPKG
	if grep -q CONFIG_SYSLOGD=y $(@D)/.config; then \
		$(INSTALL) -m 0755 -D package/busybox/S08logging \
			$(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)/etc/init.d/S08logging; \
	else rm -f $(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)/etc/init.d/S08logging; fi
endef

# We do this here to avoid busting a modified .config in configure
BUSYBOX_POST_EXTRACT_HOOKS += BUSYBOX_COPY_CONFIG

define BUSYBOX_CONFIGURE_CMDS
	$(BUSYBOX_SET_SYSKLOGD)
	$(BUSYBOX_SET_BB_PWD)
	$(BUSYBOX_SET_LARGEFILE)
	$(BUSYBOX_SET_IPV6)
	$(BUSYBOX_SET_RPC)
	$(BUSYBOX_PREFER_STATIC)
	$(BUSYBOX_SET_MDEV)
	$(BUSYBOX_NETKITBASE)
	$(BUSYBOX_NETKITTELNET)
	$(BUSYBOX_INTERNAL_SHADOW_PASSWORDS)
	$(BUSYBOX_DISABLE_MMU_APPLETS)
	@yes "" | $(MAKE) ARCH=$(KERNEL_ARCH) CROSS_COMPILE="$(TARGET_CROSS)" \
		-C $(@D) oldconfig
endef

define BUSYBOX_BUILD_CMDS
	$(BUSYBOX_MAKE_ENV) $(MAKE) $(BUSYBOX_MAKE_OPTS) -C $(@D)
endef

define BUSYBOX_INSTALL_TARGET_CMDS
	$(BUSYBOX_MAKE_ENV) $(MAKE) $(BUSYBOX_MAKE_OPTS) -C $(@D) install
	if [ ! -f $(TARGET_DIR)/usr/share/udhcpc/default.script ]; then \
		$(INSTALL) -m 0755 -D package/busybox/udhcpc.script \
			$(TARGET_DIR)/usr/share/udhcpc/default.script; \
	fi
	$(BUSYBOX_INSTALL_MDEV_SCRIPT)
	$(BUSYBOX_INSTALL_MDEV_CONF)
	$(BUSYBOX_INSTALL_LOGGING_SCRIPT)
endef

define BUSYBOX_BUILD_OPKG_CMDS
	mkdir -p $(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)
	$(BUSYBOX_MAKE_ENV) $(MAKE) $(BUSYBOX_MAKE_OPTS_OPKG) -C $(@D) install
	if [ ! -f $(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)/usr/share/udhcpc/default.script ]; then \
		$(INSTALL) -m 0755 -D package/busybox/udhcpc.script \
			$(BUILD_DIR_OPKG)/$(BUSYBOX_BASE_NAME)/usr/share/udhcpc/default.script; \
	fi
	$(BUSYBOX_INSTALL_MDEV_SCRIPT_OPKG)
	$(BUSYBOX_INSTALL_MDEV_CONF_OPKG)
	$(BUSYBOX_INSTALL_LOGGING_SCRIPT_OPKG)
endef

define BUSYBOX_UNINSTALL_TARGET_CMDS
	$(BUSYBOX_MAKE_ENV) $(MAKE) $(BUSYBOX_MAKE_OPTS) -C $(@D) uninstall
endef

define BUSYBOX_CLEAN_CMDS
	$(BUSYBOX_MAKE_ENV) $(MAKE) $(BUSYBOX_MAKE_OPTS) -C $(@D) clean
endef

$(eval $(call GENTARGETS,package,busybox))

busybox-menuconfig: busybox-patch
	$(BUSYBOX_MAKE_ENV) $(MAKE) $(BUSYBOX_MAKE_OPTS) -C $(BUSYBOX_DIR) menuconfig
	rm -f $(BUSYBOX_DIR)/.stamp_built
	rm -f $(BUSYBOX_DIR)/.stamp_target_installed

busybox-update:
	cp -f $(BUSYBOX_BUILD_CONFIG) $(BUSYBOX_CONFIG_FILE)
