#############################################################
#
# libjpeg-turbo
#
#############################################################
LIBJPEG_TURBO_VERSION = 1.1.1
LIBJPEG_TURBO_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/libjpeg-turbo/$(LIBJPEG_TURBO_VERSION)
LIBJPEG_TURBO_SOURCE = libjpeg-turbo-$(LIBJPEG_TURBO_VERSION).tar.gz
LIBJPEG_TURBO_INSTALL_STAGING = YES
LIBJPEG_TURBO_INSTALL_TARGET = YES
LIBJPEG_TURBO_DEPENDENCIES = host-nasm
LIBJPEG_TURBO_BUILD_OPKG = YES

LIBJPEG_TURBO_SECTION = graphics
LIBJPEG_TURBO_PRIORITY = optional
LIBJPEG_TURBO_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBJPEG_TURBO_DESCRIPTION = a high-speed version of libjpeg for x86 and x86-64 processors which uses SIMD instructions (MMX, SSE2, etc.) to accelerate baseline JPEG compression and decompression

$(eval $(call AUTOTARGETS,package,libjpeg-turbo))
