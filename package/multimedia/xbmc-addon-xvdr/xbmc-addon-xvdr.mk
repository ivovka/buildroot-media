#############################################################
#
# xbmc-addon-xvdr
#
#############################################################
#XBMC_ADDON_XVDR_VERSION = 22-gd973f41
XBMC_ADDON_XVDR_VERSION = 59-g8d57661
XBMC_ADDON_XVDR_XVDR_VERSION = 0.9.5
XBMC_ADDON_XVDR_SITE = https://nodeload.github.com
XBMC_ADDON_XVDR_SOURCE = pipelka-xbmc-addon-xvdr-xvdr-$(XBMC_ADDON_XVDR_XVDR_VERSION)-$(XBMC_ADDON_XVDR_VERSION).tar.gz

XBMC_ADDON_XVDR_INSTALL_STAGING = NO
XBMC_ADDON_XVDR_INSTALL_TARGET = YES
XBMC_ADDON_XVDR_BUILD_OPKG = YES
XBMC_ADDON_XVDR_SECTION = multimedia
XBMC_ADDON_XVDR_DESCRIPTION = Standalone XVDR addon for XBMC
XBMC_ADDON_XVDR_OPKG_DEPENDENCIES = xbmc
XBMC_ADDON_XVDR_DEPENDENCIES = xbmc
XBMC_ADDON_XVDR_AUTORECONF = YES

define XBMC_ADDON_XVDR_ADD_MISSING_FILES
    touch $(XBMC_ADDON_XVDR_DIR)/NEWS
    touch $(XBMC_ADDON_XVDR_DIR)/AUTHORS
    touch $(XBMC_ADDON_XVDR_DIR)/ChangeLog
endef

define XBMC_ADDON_XVDR_MV_LIB
    mkdir -p $(BUILD_DIR_OPKG)/xbmc-addon-xvdr-$(XBMC_ADDON_XVDR_VERSION)/usr/lib/xbmc/addons/pvr.vdr.xvdr
    mv $(BUILD_DIR_OPKG)/xbmc-addon-xvdr-$(XBMC_ADDON_XVDR_VERSION)/usr/share/xbmc/addons/pvr.vdr.xvdr/XBMC_VDR_xvdr.pvr $(BUILD_DIR_OPKG)/xbmc-addon-xvdr-$(XBMC_ADDON_XVDR_VERSION)/usr/lib/xbmc/addons/pvr.vdr.xvdr/
endef

XBMC_ADDON_XVDR_POST_PATCH_HOOKS += XBMC_ADDON_XVDR_ADD_MISSING_FILES
XBMC_ADDON_XVDR_PRE_BUILD_OPKG_HOOKS += XBMC_ADDON_XVDR_MV_LIB

XBMC_ADDON_XVDR_CONF_OPT = --prefix=/usr/share/xbmc
$(eval $(call AUTOTARGETS,package/multimedia,xbmc-addon-xvdr))
