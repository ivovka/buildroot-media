#############################################################
#
# libgcrypt
#
#############################################################

LIBGCRYPT_VERSION = 1.5.0
LIBGCRYPT_SOURCE = libgcrypt-$(LIBGCRYPT_VERSION).tar.bz2
LIBGCRYPT_SITE = ftp://ftp.gnupg.org/gcrypt/libgcrypt
LIBGCRYPT_INSTALL_STAGING = YES
LIBGCRYPT_BUILD_OPKG = YES
LIBGCRYPT_DEPENDENCIES = libgpg-error
LIBGCRYPT_OPKG_DEPENDENCIES = libgpg-error

LIBGCRYPT_SECTION = security
LIBGCRYPT_DESCRIPTION = General purpose cryptographic library

LIBGCRYPT_CONF_ENV = \
	ac_cv_sys_symbol_underscore=no
LIBGCRYPT_CONF_OPT = \
	--disable-asm \
	--with-gpg-error-prefix=$(STAGING_DIR)/usr

define LIBGCRYPT_OPKG_CLEANUP
  rm -rf $(BUILD_DIR_OPKG)/$(LIBGCRYPT_BASE_NAME)/usr/{bin,sbin}
endef

LIBGCRYPT_PRE_BUILD_OPKG_HOOKS += LIBGCRYPT_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package,libgcrypt))
