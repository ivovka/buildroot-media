#############################################################
#
# libgpg-error
#
#############################################################
LIBGPG_ERROR_VERSION:=1.10
LIBGPG_ERROR_SOURCE:=libgpg-error-$(LIBGPG_ERROR_VERSION).tar.bz2
LIBGPG_ERROR_SITE:=ftp://gd.tuwien.ac.at/privacy/gnupg/libgpg-error

LIBGPG_ERROR_INSTALL_STAGING = YES
LIBGPG_ERROR_BUILD_OPKG = YES

LIBGPG_ERROR_SECTION = security
LIBGPG_ERROR_DESCRIPTION = Library that defines common error values for GnuPG components

define LIBGPG_ERROR_OPKG_RM_BIN
  rm -rf $(BUILD_DIR_OPKG)/$(LIBGPG_ERROR_BASE_NAME)/usr/{bin,share}
endef

LIBGPG_ERROR_PRE_BUILD_OPKG_HOOKS += LIBGPG_ERROR_OPKG_RM_BIN

$(eval $(call AUTOTARGETS,package,libgpg-error))
