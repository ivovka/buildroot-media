#############################################################
#
# hdparm
#
#############################################################
HDPARM_VERSION = 9.37
HDPARM_SOURCE = hdparm-$(HDPARM_VERSION).tar.gz
HDPARM_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/hdparm

HDPARM_BUILD_OPKG = YES
HDPARM_SECTION = tools
HDPARM_DESCRIPTION = Get/set hard disk parameters

define HDPARM_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef

ifeq ($(BR2_HAVE_DOCUMENTATION),y)
define HDPARM_INSTALL_DOCUMENTATION
	$(INSTALL) -D $(@D)/hdparm.8 $(TARGET_DIR)/usr/share/man/man8/hdparm.8
endef
endif

define HDPARM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/hdparm $(TARGET_DIR)/sbin/hdparm
	$(HDPARM_INSTALL_DOCUMENTATION)
endef

define HDPARM_BUILD_OPKG_CMDS
	mkdir -p $(BUILD_DIR_OPKG)/$(HDPARM_BASE_NAME)/sbin
	$(INSTALL) -D -m 0755 $(@D)/hdparm $(BUILD_DIR_OPKG)/$(HDPARM_BASE_NAME)/sbin/hdparm
endef

define HDPARM_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/sbin/hdparm
	rm -f $(TARGET_DIR)/usr/share/man/man8/hdparm.8
endef

define HDPARM_CLEAN_CMDS
	-$(MAKE) -C $(@D) clean
endef

$(eval $(call GENTARGETS,package,hdparm))
