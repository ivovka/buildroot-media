#############################################################
#
# kmod
#
#############################################################
KMOD_VERSION = 7
KMOD_SOURCE = kmod-$(KMOD_VERSION).tar.xz
KMOD_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/kernel/kmod/
KMOD_INSTALL_STAGING = YES
KMOD_BUILD_OPKG = YES

KMOD_SECTION = system
KMOD_DESCRIPTION = The new module loader
KMOD_OPKG_DEPENDENCIES = libc
KMOD_CONF_OPT = \
	--disable-tools

$(eval $(call AUTOTARGETS,package,kmod))
