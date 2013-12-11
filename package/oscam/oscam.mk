#############################################################
#
# oscam
#
#############################################################

OSCAM_VERSION = 9071
OSCAM_SITE = http://www.streamboard.tv/oscam/browser/trunk
OSCAM_SOURCE = oscam-$(OSCAM_VERSION).tar.gz

OSCAM_INSTALL_STAGING = NO
OSCAM_INSTALL_TARGET = YES
OSCAM_BUILD_OPKG = YES
OSCAM_SECTION = security
OSCAM_DESCRIPTION = OSCam is an Open Source Conditional Access Module software

ifeq ($(BR2_OSCAM_USE_DEFAULT_CONF),y)
  OSCAM_CONF_OPTS=--restore
else
  OSCAM_CONF_OPTS=--disable all --enable $(BR2_OSCAM_ADDONS) $(BR2_OSCAM_PROTOCOLS) $(BR2_OSCAM_READERS)
endif
define OSCAM_CONFIGURE_CMDS
    cd $(OSCAM_DIR) && ./config.sh $(OSCAM_CONF_OPTS)
endef

define OSCAM_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) HOST_CC="$(HOSTCC)" PREFIX=/usr $(MAKE) CROSS=$(TARGET_CROSS) CONF_DIR=/etc EXTRA_LDFLAGS="$(LDFLAGS)" HOSTCC="$(HOSTCC)" HOSTCFLAGS="$(CFLAGS_FOR_BUILD)" BINDIR=Distribution OSCAM_BIN=Distribution/oscam-$(OSCAM_VERSION) -C $(@D)
endef

define OSCAM_INSTALL_TARGET_CMDS
endef

define OSCAM_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/oscam-$(OSCAM_VERSION)/usr/bin
    $(INSTALL) $(OSCAM_DIR)/Distribution/oscam-$(OSCAM_VERSION) $(BUILD_DIR_OPKG)/oscam-$(OSCAM_VERSION)/usr/bin
endef
$(eval $(call GENTARGETS,package,oscam))
