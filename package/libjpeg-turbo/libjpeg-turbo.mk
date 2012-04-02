#############################################################
#
# libjpeg-turbo
#
#############################################################
LIBJPEG_TURBO_VERSION = 1.2.0
LIBJPEG_TURBO_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/libjpeg-turbo/$(LIBJPEG_TURBO_VERSION)
LIBJPEG_TURBO_SOURCE = libjpeg-turbo-$(LIBJPEG_TURBO_VERSION).tar.gz
LIBJPEG_TURBO_INSTALL_STAGING = YES
LIBJPEG_TURBO_INSTALL_TARGET = YES
LIBJPEG_TURBO_DEPENDENCIES = host-nasm
LIBJPEG_TURBO_BUILD_OPKG = YES

LIBJPEG_TURBO_SECTION = graphics
LIBJPEG_TURBO_DESCRIPTION = a high-speed version of libjpeg for x86 and x86-64 processors which uses SIMD instructions (MMX, SSE2, etc.) to accelerate baseline JPEG compression and decompression

LIBJPEG_TURBO_CONF_OPT += --with-jpeg8

define LIBJPEG_TURBO_OPKG_RM_BIN
  rm -rf $(BUILD_DIR_OPKG)/$(LIBJPEG_TURBO_BASE_NAME)/usr/bin
endef

LIBJPEG_TURBO_PRE_BUILD_OPKG_HOOKS += LIBJPEG_TURBO_OPKG_RM_BIN

$(eval $(call AUTOTARGETS,package,libjpeg-turbo))
