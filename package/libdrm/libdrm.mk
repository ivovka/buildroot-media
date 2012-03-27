#############################################################
#
# libdrm
#
#############################################################
LIBDRM_VERSION = 2.4.31
LIBDRM_SOURCE = libdrm-$(LIBDRM_VERSION).tar.bz2
LIBDRM_SITE = http://dri.freedesktop.org/libdrm/
LIBDRM_INSTALL_STAGING = YES
LIBDRM_BUILD_OPKG = YES

LIBDRM_SECTION = graphics
LIBDRM_DESCRIPTION = Userspace interface to kernel DRM services
LIBDRM_OPKG_DEPENDENCIES = udev,libpciaccess,libxmu,pthread-stubs

LIBDRM_DEPENDENCIES = xproto_glproto xproto_xf86vidmodeproto xlib_libXmu xproto_dri2proto pthread-stubs xlib_libpciaccess udev

LIBDRM_CONF_OPT = --disable-libkms \
	--disable-nouveau-experimental-api \
	--disable-vmgfx-experimental-api \
	--enable-udev \
	--enable-largefile

ifeq ($(BR2_PACKAGE_XDRIVER_XF86_VIDEO_INTEL),y)
LIBDRM_CONF_OPT += --enable-intel
LIBDRM_DEPENDENCIES += libatomic_ops
else
LIBDRM_CONF_OPT += --disable-intel
endif

ifneq ($(BR2_PACKAGE_XDRIVER_XF86_VIDEO_ATI),y)
LIBDRM_CONF_OPT += --disable-radeon
endif

$(eval $(call AUTOTARGETS,package,libdrm))
