#############################################################
#
# PCRE
#
#############################################################

PCRE_VERSION = 8.30
PCRE_SITE = ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre
PCRE_INSTALL_STAGING = YES
PCRE_BUILD_OPKG = YES

PCRE_SECTION = devel
PCRE_PRIORITY = optional
PCRE_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
PCRE_DESCRIPTION = Perl Compatible Regulat Expressions

PCRE_CONF_OPT = --enable-unicode-properties --enable-utf8
ifneq ($(BR2_INSTALL_LIBSTDCPP),y)
# pcre will use the host g++ if a cross version isn't available
PCRE_CONF_OPT += --disable-cpp
endif

define PCRE_STAGING_PCRE_CONFIG_FIXUP
	$(SED) 's,^prefix=.*,prefix=$(STAGING_DIR)/usr,' \
		-e 's,^exec_prefix=.*,exec_prefix=$(STAGING_DIR)/usr,' \
		$(STAGING_DIR)/usr/bin/pcre-config
endef

PCRE_POST_INSTALL_STAGING_HOOKS += PCRE_STAGING_PCRE_CONFIG_FIXUP

define PCRE_TARGET_REMOVE_PCRE_CONFIG
	rm -f $(TARGET_DIR)/usr/bin/pcre-config
endef

define PCRE_OPKG_REMOVE_PCRE_CONFIG
	rm -f $(BUILD_DIR_OPKG)/pcre-$(PCRE_VERSION)/usr/bin/pcre-config
endef

ifneq ($(BR2_HAVE_DEVFILES),y)
PCRE_POST_INSTALL_TARGET_HOOKS += PCRE_TARGET_REMOVE_PCRE_CONFIG
PCRE_PRE_BUILD_OPKG_HOOKS += PCRE_OPKG_REMOVE_PCRE_CONFIG
endif

$(eval $(call AUTOTARGETS,package,pcre))
