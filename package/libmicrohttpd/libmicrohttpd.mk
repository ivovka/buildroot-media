#############################################################
#
# libmicrohttpd
#
#############################################################
LIBMICROHTTPD_VERSION = 0.9.9
LIBMICROHTTPD_SOURCE = libmicrohttpd-$(LIBMICROHTTPD_VERSION).tar.gz
LIBMICROHTTPD_SITE = $(BR2_GNU_MIRROR)/libmicrohttpd
LIBMICROHTTPD_INSTALL_STAGING = YES
LIBMICROHTTPD_BUILD_OPKG = YES

LIBMICROHTTPD_SECTION = web
LIBMICROHTTPD_PRIORITY = optional
LIBMICROHTTPD_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBMICROHTTPD_DESCRIPTION = a small webserver C library

ifeq ($(BR2_PACKAGE_LIBMICROHTTPD_SSL),y)
LIBMICROHTTPD_DEPENDENCIES += libgcrypt gnutls
LIBMICROHTTPD_OPKG_DEPENDENCIES = libgcrypt,gnutls
LIBMICROHTTPD_CONF_OPT += --enable-https \
			  --with-libgcrypt-prefix=$(STAGING_DIR)/usr
else
LIBMICROHTTPD_CONF_OPT += --disable-https
endif

$(eval $(call AUTOTARGETS,package,libmicrohttpd))
