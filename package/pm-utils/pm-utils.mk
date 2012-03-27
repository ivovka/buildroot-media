PM_UTILS_VERSION = 1.4.1
PM_UTILS_SOURCE = pm-utils-$(PM_UTILS_VERSION).tar.gz
PM_UTILS_SITE = http://pm-utils.freedesktop.org/releases
PM_UTILS_INSTALL_STAGING = NO
PM_UTILS_BUILD_OPKG = YES
PM_UTILS_SECTION = system
PM_UTILS_DESCRIPTION = a small collection of scripts that handle suspend and resume on behalf of HAL.
PM_UTILS_OPKG_DEPENDENCIES = kbd

define PM_UTILS_COPY_QUIRKS
    mkdir -p $(BUILD_DIR_OPKG)/$(PM_UTILS_BASE_NAME)/etc/pm/config.d
    cp $(TOPDIR)/package/pm-utils/config.d/* $(BUILD_DIR_OPKG)/$(PM_UTILS_BASE_NAME)/etc/pm/config.d
    mkdir -p $(BUILD_DIR_OPKG)/$(PM_UTILS_BASE_NAME)/usr/lib/pm-utils/video-quirks/
    cp $(TOPDIR)/package/pm-utils/quirks/*.quirkdb $(BUILD_DIR_OPKG)/$(PM_UTILS_BASE_NAME)/usr/lib/pm-utils/video-quirks/
endef

PM_UTILS_PRE_BUILD_OPKG_HOOKS += PM_UTILS_COPY_QUIRKS

$(eval $(call AUTOTARGETS,package,pm-utils))
