#############################################################
#
# freetype
#
#############################################################
FREETYPE_VERSION = 2.4.9
FREETYPE_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/freetype
FREETYPE_SOURCE = freetype-$(FREETYPE_VERSION).tar.bz2
FREETYPE_INSTALL_STAGING = YES
FREETYPE_INSTALL_TARGET = YES
FREETYPE_BUILD_OPKG = YES

FREETYPE_SECTION = print
FREETYPE_PRIORITY = optional
FREETYPE_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
FREETYPE_DESCRIPTION = TrueType font rendering library
FREETYPE_OPKG_DEPENDENCIES = zlib

FREETYPE_MAKE_OPT = CCexe="$(HOSTCC)"
FREETYPE_DEPENDENCIES = host-pkg-config $(if $(BR2_PACKAGE_ZLIB),zlib)

# Make freetype depends on host-freetype, because I am not sure wich packages really use freetype on host
FREETYPE_DEPENDENCIES += host-freetype

HOST_FREETYPE_DEPENDENCIES = host-pkg-config

define FREETYPE_FREETYPE_CONFIG_STAGING_FIXUP
	$(SED) "s,^prefix=.*,prefix=\'$(STAGING_DIR)/usr\',g" \
		-e "s,^exec_prefix=.*,exec_prefix=\'$(STAGING_DIR)/usr\',g" \
		-e "s,^includedir=.*,includedir=\'$(STAGING_DIR)/usr/include/freetype2\',g" \
		-e "s,^libdir=.*,libdir=\'$(STAGING_DIR)/usr/lib\',g" \
		$(STAGING_DIR)/usr/bin/freetype-config
endef

FREETYPE_POST_INSTALL_STAGING_HOOKS += FREETYPE_FREETYPE_CONFIG_STAGING_FIXUP

define FREETYPE_FREETYPE_CONFIG_REMOVE
    rm -f $1/usr/bin/freetype-config
endef

define FREETYPE_FREETYPE_CONFIG_TARGET_REMOVE
    $(call FREETYPE_FREETYPE_CONFIG_REMOVE,$(TARGET_DIR))
endef

define FREETYPE_FREETYPE_CONFIG_OPKG_REMOVE
    $(call FREETYPE_FREETYPE_CONFIG_REMOVE,$(BUILD_DIR_OPKG)/freetype-$(FREETYPE_VERSION))
endef

ifneq ($(BR2_HAVE_DEVFILES),y)
FREETYPE_POST_INSTALL_TARGET_HOOKS += FREETYPE_FREETYPE_CONFIG_TARGET_REMOVE
FREETYPE_PRE_BUILD_OPKG_HOOKS += FREETYPE_FREETYPE_CONFIG_OPKG_REMOVE
endif

$(eval $(call AUTOTARGETS,package,freetype))
$(eval $(call AUTOTARGETS,package,freetype,host))
