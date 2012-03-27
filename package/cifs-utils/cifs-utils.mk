CIFS_UTILS_VERSION = 5.0
CIFS_UTILS_SOURCE = cifs-utils-$(CIFS_UTILS_VERSION).tar.bz2
CIFS_UTILS_SITE = ftp://ftp.samba.org/pub/linux-cifs/cifs-utils
CIFS_UTILS_INSTALL_STAGING = NO
CIFS_UTILS_BUILD_OPKG = YES
CIFS_UTILS_SECTION = network
CIFS_UTILS_DESCRIPTION = a set of user-space tools to mount/umount CIFS filesystems
CIFS_UTILS_OPKG_DEPENDENCIES = libcap
CIFS_UTILS_DEPENDENCIES = libcap

CIFS_UTILS_CONF_ENV = ac_cv_func_malloc_0_nonnull=yes

CIFS_UTILS_CONF_OPT = --disable-cifsupcall \
    --disable-cifscreds \
    --with-libcap

define CIFS_UTILS_RM_USR
    rm -rf $(BUILD_DIR_OPKG)/$(CIFS_UTILS_BASE_NAME)/usr
endef

CIFS_UTILS_PRE_BUILD_OPKG_HOOKS += CIFS_UTILS_RM_USR

$(eval $(call AUTOTARGETS,package,cifs-utils))
