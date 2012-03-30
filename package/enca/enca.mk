#############################################################
#
## enca
#
##############################################################

ENCA_VERSION= 1.13
ENCA_SOURCE = enca-$(ENCA_VERSION).tar.bz2
ENCA_SITE = http://dl.cihar.com/enca
ENCA_INSTALL_STAGING = YES
ENCA_AUTORECONF = YES
ENCA_BUILD_OPKG = YES

ENCA_SECTION = text
ENCA_DESCRIPTION = detects the encoding of text files, on the basis of knowledge of their language.

ifneq ($(BR2_ENABLE_LOCALE),y)
    ENCA_DEPENDENCIES+=libiconv
endif

ENCA_CONF_ENV = \
    ac_cv_file__dev_random=yes \
    ac_cv_file__dev_urandom=no \
    ac_cv_file__dev_srandom=no \
    ac_cv_file__dev_arandom=no \
    am_cv_func_iconv=yes \
    yeti_cv_file_locale_alias=/usr/share/locale/locale.alias \
    CFLAGS="$(TARGET_CFLAGS) -DICONV_CONST="
ENCA_CONF_OPT = --disable-gtk-doc \
	--disable-external \
	--disable-rpath \
	--without-librecode \
	--enable-shared \
	--disable-static

define ENCA_CP_LOCALE_ALIAS
    mkdir -p $(TARGET_DIR)/usr/share/locale && \
    install -c -m 644 $(STAGING_DIR)/usr/share/locale/locale.alias $(TARGET_DIR)/usr/share/locale/
endef

define ENCA_OPKG_RM_BIN
	rm -rf $(BUILD_DIR_OPKG)/$(ENCA_BASE_NAME)/usr/{bin,libexec}
endef

ENCA_PRE_BUILD_OPKG_HOOKS += ENCA_OPKG_RM_BIN

ENCA_POST_INSTALL_TARGET_HOOKS += ENCA_CP_LOCALE_ALIAS

$(eval $(call AUTOTARGETS,package,enca))
