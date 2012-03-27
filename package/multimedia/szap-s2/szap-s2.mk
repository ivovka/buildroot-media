#############################################################
#
# szap-s2
#
#############################################################
SZAP_S2_VERSION = d65015db2778
SZAP_S2_SITE = http://mercurial.intuxication.org/hg/szap-s2
SZAP_S2_SOURCE = szap-s2-$(SZAP_S2_VERSION).tar.bz2
SZAP_S2_INSTALL_STAGING = NO
SZAP_S2_INSTALL_TARGET = YES
SZAP_S2_BUILD_OPKG = YES
SZAP_S2_SECTION = multimedia
SZAP_S2_DESCRIPTION = DVB-S(S2) szap-s2 utility for Linux

define SZAP_S2_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
    BUILD_CC="$(HOSTCC)" BUILD_CFLAGS="$(HOST_CFLAGS)"
endef

define SZAP_S2_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/bin
    cp $(@D)/szap-s2 $(TARGET_DIR)/usr/bin/szap-s2
endef

define SZAP_S2_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/szap-s2-$(SZAP_S2_VERSION)/usr/bin
    cp $(@D)/szap-s2 $(BUILD_DIR_OPKG)/szap-s2-$(SZAP_S2_VERSION)/usr/bin/szap-s2
endef

$(eval $(call GENTARGETS,package/multimedia,szap-s2))
