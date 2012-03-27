KBD_VERSION = 1.15.2
KBD_SOURCE = kbd-$(KBD_VERSION).tar.gz
KBD_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/kbd
KBD_BUILD_OPKG = YES
KBD_SECTION = system
KBD_DESCRIPTION = Keyboard and console utilities for Linux

KBD_DEPENDENCIES = $(if $(BR2_NEEDS_GETTEXT_IF_LOCALE),gettext libintl)

define KBD_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/$(KBD_BASE_NAME)/usr/bin
    cp $(BUILD_DIR)/$(KBD_BASE_NAME)/src/chvt $(BUILD_DIR_OPKG)/$(KBD_BASE_NAME)/usr/bin
    cp $(BUILD_DIR)/$(KBD_BASE_NAME)/src/deallocvt $(BUILD_DIR_OPKG)/$(KBD_BASE_NAME)/usr/bin
    cp $(BUILD_DIR)/$(KBD_BASE_NAME)/src/fgconsole $(BUILD_DIR_OPKG)/$(KBD_BASE_NAME)/usr/bin
endef

$(eval $(call AUTOTARGETS,package,kbd))
