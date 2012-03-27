#############################################################
#
# scan-s2
#
#############################################################
SCAN_S2_VERSION = 7effc68db255
SCAN_S2_SITE = http://mercurial.intuxication.org/hg/scan-s2
SCAN_S2_SOURCE = scan-s2-$(SCAN_S2_VERSION).tar.bz2
SCAN_S2_INSTALL_STAGING = NO
SCAN_S2_INSTALL_TARGET = YES
SCAN_S2_BUILD_OPKG = YES
SCAN_S2_SECTION = multimedia
SCAN_S2_DESCRIPTION = DVB scan utility using S2API

define SCAN_S2_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
    BUILD_CC="$(HOSTCC)" BUILD_CFLAGS="$(HOST_CFLAGS)"
endef

define SCAN_S2_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/bin
    cp $(@D)/scan-s2 $(TARGET_DIR)/usr/bin/scan-s2
endef

define SCAN_S2_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/scan-s2-$(SCAN_S2_VERSION)/usr/bin
    cp $(@D)/scan-s2 $(BUILD_DIR_OPKG)/scan-s2-$(SCAN_S2_VERSION)/usr/bin/scan-s2
endef

$(eval $(call GENTARGETS,package/multimedia,scan-s2))
