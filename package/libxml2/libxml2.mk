#############################################################
#
# libxml2
#
#############################################################

LIBXML2_VERSION = 2.7.8
LIBXML2_SITE = ftp://xmlsoft.org/libxml2
LIBXML2_INSTALL_STAGING = YES
LIBXML2_BUILD_OPKG = YES
LIBXML2_DEPENDENCIES = zlib host-libxml2
LIBXML2_OPKG_DEPENDENCIES = zlib
HOST_LIBXML2_DEPENDENCIES = host-pkg-config host-python host-zlib

LIBXML2_SECTION = libs
LIBXML2_DESCRIPTION = XML parser library for Gnome

ifneq ($(BR2_LARGEFILE),y)
LIBXML2_CONF_ENV = CC="$(TARGET_CC) $(TARGET_CFLAGS) -DNO_LARGEFILE_SOURCE"
endif

LIBXML2_CONF_OPT = --with-gnu-ld --without-python --without-debug --with-iconv --disable-ipv6 --with-zlib

define LIBXML2_STAGING_LIBXML2_CONFIG_FIXUP
	$(SED) "s,^prefix=.*,prefix=\'$(STAGING_DIR)/usr\',g" $(STAGING_DIR)/usr/bin/xml2-config
	$(SED) "s,^exec_prefix=.*,exec_prefix=\'$(STAGING_DIR)/usr\',g" $(STAGING_DIR)/usr/bin/xml2-config
endef

LIBXML2_POST_INSTALL_STAGING_HOOKS += LIBXML2_STAGING_LIBXML2_CONFIG_FIXUP

HOST_LIBXML2_CONF_OPT = --with-python --with-zlib --disable-ipv6

define LIBXML2_REMOVE_CONFIG_SCRIPTS
	$(RM) -f $1/usr/bin/xml2-config
endef

define LIBXML2_REMOVE_CONFIG_TARGET
    $(call LIBXML2_REMOVE_CONFIG_SCRIPTS,$(TARGET_DIR))
endef

define LIBXML2_REMOVE_CONFIG_OPKG
    $(call LIBXML2_REMOVE_CONFIG_SCRIPTS,$(BUILD_DIR_OPKG)/libxml2-$(LIBXML2_VERSION))
endef

define LIBXML2_OPKG_REMOVE_BIN
	rm -rf $(BUILD_DIR_OPKG)/$(LIBXML2_BASE_NAME)/usr/bin
	rm $(BUILD_DIR_OPKG)/$(LIBXML2_BASE_NAME)/usr/lib/xml2Conf.sh
endef

LIBXML2_PRE_BUILD_OPKG_HOOKS += LIBXML2_OPKG_REMOVE_BIN

ifneq ($(BR2_HAVE_DEVFILES),y)
LIBXML2_POST_INSTALL_TARGET_HOOKS += LIBXML2_REMOVE_CONFIG_TARGET
LIBXML2_PRE_BUILD_OPKG_HOOKS += LIBXML2_REMOVE_CONFIG_OPKG
endif

$(eval $(call AUTOTARGETS,package,libxml2))
$(eval $(call AUTOTARGETS,package,libxml2,host))

# libxml2 for the host
LIBXML2_HOST_BINARY:=$(HOST_DIR)/usr/bin/xmllint
