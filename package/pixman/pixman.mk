################################################################################
#
# pixman
#
################################################################################
PIXMAN_VERSION = 0.25.2
PIXMAN_SOURCE = pixman-$(PIXMAN_VERSION).tar.gz
PIXMAN_SITE = http://xorg.freedesktop.org/archive/individual/lib
PIXMAN_AUTORECONF = YES
PIXMAN_INSTALL_STAGING = YES
PIXMAN_BUILD_OPKG = YES
PIXMAN_OPKG_DEPENDENCIES = libc

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

define PIXMAN_STAGING_FIXNAMES
    cp $(STAGING_DIR)/usr/lib/pkgconfig/pixman-1.pc $(STAGING_DIR)/usr/lib/pkgconfig/pixman.pc
    cp -rf $(STAGING_DIR)/usr/include/pixman-1 $(STAGING_DIR)/usr/include/pixman
endef

PIXMAN_POST_PATCH_HOOKS += PIXMAN_NO_TEST
PIXMAN_POST_INSTALL_STAGING_HOOKS += PIXMAN_STAGING_FIXNAMES

$(eval $(call AUTOTARGETS,package,pixman))
$(eval $(call AUTOTARGETS,package,pixman,host))
