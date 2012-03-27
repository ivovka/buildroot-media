################################################################################
#
# pixman
#
################################################################################
PIXMAN_VERSION = 0.24.4
PIXMAN_SOURCE = pixman-$(PIXMAN_VERSION).tar.gz
PIXMAN_SITE = http://cairographics.org/releases/
PIXMAN_AUTORECONF = NO
PIXMAN_INSTALL_STAGING = YES
PIXMAN_BUILD_OPKG = YES

PIXMAN_SECTION = x11
PIXMAN_DESCRIPTION = Pixel manipulation library
PIXMAN_DEPENDENCIES = xutil_util-macros

PIXMAN_CONF_OPT = \
	--disable-openmp \
	--enable-gcc-inline-asm \
	--disable-timers \
	--disable-gtk
ifeq ($(BR2_i386)$(BR2_x86_64),y)
PIXMAN_CONF_OPT += \
	--enable-mmx \
	--enable-sse2 \
	--disable-vmx \
	--disable-arm-simd \
	--disable-arm-neon
endif

define PIXMAN_NO_TEST
    echo "" > $(PIXMAN_DIR)/test/Makefile.am
endef

PIXMAN_POST_PATCH_HOOKS += PIXMAN_NO_TEST

$(eval $(call AUTOTARGETS,package,pixman))
$(eval $(call AUTOTARGETS,package,pixman,host))
