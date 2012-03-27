#############################################################
#
# grep
#
#############################################################

GREP_VERSION = 2.11
GREP_SITE = $(BR2_GNU_MIRROR)/grep
GREP_SOURCE = grep-$(GREP_VERSION).tar.xz
GREP_CONF_OPT = --disable-perl-regexp --without-included-regex
GREP_DEPENDENCIES = $(if $(BR2_NEEDS_GETTEXT_IF_LOCALE),gettext libintl)
GREP_BUILD_OPKG = YES
GREP_SECTION = system
GREP_DESCRIPTION = The GNU regular expression matcher

# link with iconv if enabled
ifeq ($(BR2_PACKAGE_LIBICONV),y)
GREP_CONF_ENV += LIBS=-liconv
GREP_DEPENDENCIES += libiconv
endif

define GREP_RM_LOCALE
    rm -rf $(BUILD_DIR_OPKG)/$(GREP_BASE_NAME)/usr/share
endef

GREP_PRE_BUILD_OPKG_HOOKS += GREP_RM_LOCALE

$(eval $(call AUTOTARGETS,package,grep))
