#############################################################
#
# libgpg-error
#
#############################################################
LIBGPG_ERROR_VERSION:=1.8
LIBGPG_ERROR_SOURCE:=libgpg-error-$(LIBGPG_ERROR_VERSION).tar.bz2
LIBGPG_ERROR_SITE:=ftp://gd.tuwien.ac.at/privacy/gnupg/libgpg-error

LIBGPG_ERROR_INSTALL_STAGING = YES
LIBGPG_ERROR_BUILD_OPKG = YES

LIBGPG_ERROR_SECTION = security
LIBGPG_ERROR_PRIORITY = optional
LIBGPG_ERROR_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBGPG_ERROR_DESCRIPTION = Library that defines common error values for GnuPG components

$(eval $(call AUTOTARGETS,package,libgpg-error))
