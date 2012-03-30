#############################################################
#
# fribidi
#
#############################################################

FRIBIDI_VERSION = 0.19.2
FRIBIDI_SITE = http://fribidi.org/download
FRIBIDI_SOURCE = fribidi-$(FRIBIDI_VERSION).tar.gz
FRIBIDI_INSTALL_STAGING = YES
FRIBIDI_INSTALL_TARGET = YES
FRIBIDI_BUILD_OPKG = YES

FRIBIDI_SECTION = other
FRIBIDI_DESCRIPTION = The Bidirectional Algorithm library
FRIBIDI_CONF_OPT = --without-glib \
    --disable-debug \
    --disable-malloc \
    --enable-charsets

define FRIBIDI_OPKG_RM_BIN
    rm -rf $(BUILD_DIR_OPKG)/$(FRIBIDI_BASE_NAME)/usr/bin
endef

FRIBIDI_PRE_BUILD_OPKG_HOOKS += FRIBIDI_OPKG_RM_BIN
$(eval $(call AUTOTARGETS,package,fribidi))
