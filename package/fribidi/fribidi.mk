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
FRIBIDI_PRIORITY = optional
FRIBIDI_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
FRIBIDI_DESCRIPTION = The Bidirectional Algorithm library
FRIBIDI_CONF_OPT = --with-glib=no \
    --disable-debug \
    --enable-malloc
$(eval $(call AUTOTARGETS,package,fribidi))
