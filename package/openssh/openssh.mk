#############################################################
#
# openssh
#
#############################################################

OPENSSH_VERSION = 5.9p1
OPENSSH_SITE = http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable
OPENSSH_INSTALL_STAGING = NO
OPENSSH_BUILD_OPKG = YES
OPENSSH_SECTION = net
OPENSSH_DESCRIPTION = An open re-implementation of the SSH package

OPENSSH_DEPENDENCIES = zlib openssl
OPENSSH_OPKG_DEPENDENCIES = zlib,openssl

OPENSSH_CONF_ENV = LD="$(TARGET_CC)" LDFLAGS="$(TARGET_CFLAGS)"
OPENSSH_CONF_OPT = \
  --libexecdir=/usr/lib \
  --disable-lastlog \
  --disable-utmp \
  --disable-utmpx \
  --disable-wtmp \
  --disable-wtmpx \
  --disable-strip \
  --without-rpath \
  --with-ssl-engine \
  --without-pam

define OPENSSH_OPKG_CLEANUP
  rm $(BUILD_DIR_OPKG)/$(OPENSSH_BASE_NAME)/usr/bin/{sftp,ssh-keyscan}
  rm $(BUILD_DIR_OPKG)/$(OPENSSH_BASE_NAME)/usr/lib/{ssh-keysign,ssh-pkcs11-helper}
  rm -rf $(BUILD_DIR_OPKG)/$(OPENSSH_BASE_NAME)/var
  mkdir -p $(BUILD_DIR_OPKG)/$(OPENSSH_BASE_NAME)/etc
  cp package/openssh/sshd_config $(BUILD_DIR_OPKG)/$(OPENSSH_BASE_NAME)/etc
endef

OPENSSH_PRE_BUILD_OPKG_HOOKS += OPENSSH_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package,openssh))
