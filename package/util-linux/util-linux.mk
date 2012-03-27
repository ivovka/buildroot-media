#############################################################
#
# util-linux
#
#############################################################
UTIL_LINUX_VERSION:=2.21
UTIL_LINUX_SOURCE:=util-linux-$(UTIL_LINUX_VERSION).tar.xz
UTIL_LINUX_SITE:=$(BR2_KERNEL_MIRROR)/linux/utils/util-linux/v2.21/
UTIL_LINUX_INSTALL_TARGET = YES
UTIL_LINUX_INSTALL_STAGING = YES
UTIL_LINUX_BUILD_OPKG = YES
UTIL_LINUX_SECTION = system
UTIL_LINUX_DESCRIPTION = Miscellaneous system utilities for Linux
UTIL_LINUX_CONF_ENV = gt_cv_func_gnugettext1_libintl=no scanf_cv_alloc_modifier=as

UTIL_LINUX_CONF_OPT = \
    --enable-tls \
    --disable-mount \
    --disable-fsck \
    --enable-libuuid \
    --disable-uuidd \
    --enable-libblkid \
    --disable-libmount \
    --disable-libmount-mount \
    --disable-nls \
    --disable-rpath \
    --disable-arch \
    --disable-agetty \
    --disable-cramfs \
    --disable-switch-root \
    --disable-pivot-root \
    --disable-fallocate \
    --disable-unshare \
    --disable-elvtune \
    --disable-init \
    --disable-kill \
    --disable-last \
    --disable-mesg \
    --disable-partx \
    --disable-raw \
    --disable-rename \
    --disable-reset \
    --disable-login-utils \
    --disable-schedutils \
    --disable-wall \
    --disable-write \
    --enable-chsh-only-listed \
    --disable-login-chown-vcs \
    --disable-login-stat-mail \
    --disable-pg-bell \
    --disable-require-password \
    --disable-use-tty-group \
    --disable-makeinstall-chown \
    --disable-makeinstall-setuid \
    --without-ncurses \
    --without-slang \
    --without-utempter \
    --without-pam \
    --without-selinux \
    --without-audit

define UTIL_LINUX_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/$(UTIL_LINUX_BASE_NAME)/sbin
    cp $(BUILD_DIR)/$(UTIL_LINUX_BASE_NAME)/misc-utils/blkid $(BUILD_DIR_OPKG)/$(UTIL_LINUX_BASE_NAME)/sbin
    mkdir -p $(BUILD_DIR_OPKG)/$(UTIL_LINUX_BASE_NAME)/usr/lib
    cp -PR $(BUILD_DIR)/$(UTIL_LINUX_BASE_NAME)/libblkid/src/.libs/libblkid.so* $(BUILD_DIR_OPKG)/$(UTIL_LINUX_BASE_NAME)/usr/lib
    rm -rf $(BUILD_DIR_OPKG)/$(UTIL_LINUX_BASE_NAME)/usr/lib/libblkid.so*T
    cp -PR $(BUILD_DIR)/$(UTIL_LINUX_BASE_NAME)/libuuid/src/.libs/libuuid.so* $(BUILD_DIR_OPKG)/$(UTIL_LINUX_BASE_NAME)/usr/lib
    rm -rf $(BUILD_DIR_OPKG)/$(UTIL_LINUX_BASE_NAME)/usr/lib/libuuid.so*T
endef

$(eval $(call AUTOTARGETS,package,util-linux))
