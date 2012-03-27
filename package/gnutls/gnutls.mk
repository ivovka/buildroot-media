#############################################################
#
# gnutls
#
#############################################################

GNUTLS_VERSION = 2.10.5
GNUTLS_SOURCE = gnutls-$(GNUTLS_VERSION).tar.bz2
GNUTLS_SITE = http://ftp.gnu.org/gnu/gnutls/
GNUTLS_DEPENDENCIES = libgcrypt
GNUTLS_CONF_OPT += --without-libgcrypt-prefix
GNUTLS_INSTALL_STAGING = YES
GNUTLS_BUILD_OPKG = YES

GNUTLS_SECTION = security
GNUTLS_PRIORITY = optional
GNUTLS_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
GNUTLS_DESCRIPTION = Development Library for TLS applications
GNUTLS_OPKG_DEPENDENCIES = lzo,libgcrypt

GNUTLS_CONF_OPT += \
            --with-included-libtasn1 \
            --with-lzo \
            --with-libgcrypt \
            --disable-nls

$(eval $(call AUTOTARGETS,package,gnutls))
