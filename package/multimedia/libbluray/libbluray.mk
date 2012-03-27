#############################################################
#
# libbluray
#
#############################################################

LIBBLURAY_VERSION = 51d7d60
LIBBLURAY_SITE =http://sources.openelec.tv/devel 
LIBBLURAY_INSTALL_STAGING = YES
LIBBLURAY_INSTALL_TARGET = YES
LIBBLURAY_AUTORECONF = YES
LIBBLURAY_BUILD_OPKG = YES
LIBBLURAY_SOURCE = libbluray-$(LIBBLURAY_VERSION).tar.xz

LIBBLURAY_SECTION = libs
LIBBLURAY_PRIORITY = optional
LIBBLURAY_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBBLURAY_DESCRIPTION = A Blu-Ray Discs playback library

LIBBLURAY_CONF_OPT = \
            --disable-werror \
            --disable-extra-warnings \
            --disable-optimizations \
            --disable-examples \
            --disable-debug \
            --disable-bdjava \
            --disable-doxygen-doc \
            --disable-doxygen-dot \
            --disable-doxygen-man \
            --disable-doxygen-rtf \
            --disable-doxygen-xml \
            --disable-doxygen-chm \
            --disable-doxygen-chi \
            --disable-doxygen-html \
            --disable-doxygen-ps \
            --disable-doxygen-pdf \
            --with-dlopen-crypto-libs

$(eval $(call AUTOTARGETS,package/multimedia,libbluray))
