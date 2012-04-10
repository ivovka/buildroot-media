#############################################################
#
# gnutls
#
#############################################################

GNUTLS_VERSION = 3.0.7
GNUTLS_SOURCE = gnutls-$(GNUTLS_VERSION).tar.xz
GNUTLS_SITE = http://ftp.gnu.org/gnu/gnutls/
GNUTLS_INSTALL_STAGING = YES
GNUTLS_BUILD_OPKG = YES
GNUTLS_DEPENDENCIES = cryptodev-linux zlib nettle
GNUTLS_OPKG_DEPENDENCIES = cryptodev-linux,zlib,nettle
GNUTLS_SECTION = security
GNUTLS_DESCRIPTION = Development Library for TLS applications

GNUTLS_CONF_OPT += \
  --enable-hardware-acceleration \
  --enable-cryptodev \
  --enable-openssl-compatibility \
  --without-p11-kit \
  --with-included-libtasn1 \
  --with-included-libcfg \
  --disable-nls \
  --disable-guile \
  --disable-valgrind-tests \
  --with-libnettle-prefix="$(STAGING_DIR)/usr" \
  --with-libz-prefix="$(STAGING_DIR)/usr" \
  --disable-gtk-doc \
  --disable-gtk-doc-html \
  --disable-gtk-doc-pdf

GNUTLS_BUILD_SUBDIRS = gl lib extra

define GNUTLS_BUILD_CMDS
  for dirs in $(GNUTLS_BUILD_SUBDIRS) ; do \
    $(TARGET_MAKE_ENV) $(GNUTLS_MAKE_ENV) $(GNUTLS_MAKE) $(GNUTLS_MAKE_OPT) -C $(@D)/$$dirs ; \
  done
endef

define GNUTLS_INSTALL_STAGING_CMDS
  for dirs in $(GNUTLS_BUILD_SUBDIRS) ; do \
    $(TARGET_MAKE_ENV) $(GNUTLS_MAKE_ENV) $(GNUTLS_MAKE) $(GNUTLS_INSTALL_STAGING_OPT) -C $(@D)/$$dirs ; \
  done
endef

define GNUTLS_INSTALL_TARGET_CMDS
  for dirs in $(GNUTLS_BUILD_SUBDIRS) ; do \
    $(TARGET_MAKE_ENV) $(GNUTLS_MAKE_ENV) $(GNUTLS_MAKE) $(GNUTLS_INSTALL_TARGET_OPT) -C $(@D)/$$dirs ; \
  done
endef

define GNUTLS_BUILD_OPKG_CMDS
  for dirs in $(GNUTLS_BUILD_SUBDIRS) ; do \
    $(TARGET_MAKE_ENV) $(GNUTLS_MAKE_ENV) $(GNUTLS_MAKE) $(GNUTLS_BUILD_OPKG_OPT) -C $(@D)/$$dirs ; \
  done
endef

$(eval $(call AUTOTARGETS,package,gnutls))
