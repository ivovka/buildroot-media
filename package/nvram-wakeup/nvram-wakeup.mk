#############################################################
#
# nvram-wakeup
#
#############################################################
NVRAM_WAKEUP_VERSION = 1.1
NVRAM_WAKEUP_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/nvram-wakeup
NVRAM_WAKEUP_SOURCE = nvram-wakup-$(NVRAM_WAKEUP_VERSION).tar.gz
NVRAM_WAKEUP_INSTALL_STAGING = NO
NVRAM_WAKEUP_INSTALL_TARGET = YES
NVRAM_WAKEUP_BUILD_OPKG = YES

NVRAM_WAKEUP_SECTION = system
NVRAM_WAKEUP_PRIORITY = optional
NVRAM_WAKEUP_DESCRIPTION = This is a small program that reads and writes the WakeUp time in the BIOS  

define NVRAM_WAKEUP_BUILD_CMDS
    $(TARGET_MAKE_ENV) \
    $(MAKE) -C $(@D) CC="$(TARGET_CC)" $(TARGET_MAKE_ENV)
endef

define NVRAM_WAKEUP_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) \
    $(MAKE) prefix=$(TARGET_DIR)/usr -C $(@D) install
    mkdir -p $(TARGET_DIR)/etc
    cp $(NVRAM_WAKEUP_DIR_PREFIX)/$(NVRAM_WAKEUP_NAME)/nvram-wakeup.conf $(TARGET_DIR)/etc
endef

define NVRAM_WAKEUP_BUILD_OPKG_CMDS
    $(TARGET_MAKE_ENV) \
    $(MAKE) prefix=$(BUILD_DIR_OPKG)/nvram-wakeup-$(NVRAM_WAKEUP_VERSION)/usr -C $(@D) install
    mkdir -p $(BUILD_DIR_OPKG)/nvram-wakeup-$(NVRAM_WAKEUP_VERSION)/etc
    cp $(NVRAM_WAKEUP_DIR_PREFIX)/$(NVRAM_WAKEUP_NAME)/nvram-wakeup.conf $(BUILD_DIR_OPKG)/nvram-wakeup-$(NVRAM_WAKEUP_VERSION)/etc
    rm -rf $(BUILD_DIR_OPKG)/nvram-wakeup-$(NVRAM_WAKEUP_VERSION)/usr/share
endef

$(eval $(call GENTARGETS,package,nvram-wakeup))
