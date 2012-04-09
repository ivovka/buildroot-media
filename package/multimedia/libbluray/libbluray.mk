#############################################################
#
# libbluray
#
#############################################################

LIBBLURAY_VERSION = 0.2.1
LIBBLURAY_SOURCE = libbluray-$(LIBBLURAY_VERSION).tar.bz2
LIBBLURAY_SITE = ftp://ftp.videolan.org/pub/videolan/libbluray/$(LIBBLURAY_VERSION) 
LIBBLURAY_INSTALL_STAGING = YES
LIBBLURAY_INSTALL_TARGET = YES
LIBBLURAY_AUTORECONF = YES
LIBBLURAY_BUILD_OPKG = YES
LIBBLURAY_DEPENDENCIES = libxml2 libaacs
LIBBLURAY_OPKG_DEPENDENCIES = libxml2,libaacs

LIBBLURAY_SECTION = libs
LIBBLURAY_DESCRIPTION = A Blu-Ray Discs playback library

LIBBLURAY_CONF_OPT = \
            --disable-werror \
            --disable-extra-warnings \
            --disable-optimizations \
            --disable-examples \
            --disable-debug \
            --disable-bdjava \
	    --enable-libxml2 \
            --disable-doxygen-doc \
            --disable-doxygen-dot \
            --disable-doxygen-man \
            --disable-doxygen-rtf \
            --disable-doxygen-xml \
            --disable-doxygen-chm \
            --disable-doxygen-chi \
            --disable-doxygen-html \
            --disable-doxygen-ps \
            --disable-doxygen-pdf

$(eval $(call AUTOTARGETS,package/multimedia,libbluray))
