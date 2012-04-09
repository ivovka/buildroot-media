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
define OPENSSH_INSTALL_INITSCRIPT
	$(INSTALL) -D -m 755 package/openssh/S50sshd $(TARGET_DIR)/etc/init.d/S50sshd
endef

define OPENSSH_OPKG_CLEANUP
  rm $(BUILD_DIR_OPKG)/$(OPENSSH_BASE_NAME)/usr/bin/{sftp,ssh-keyscan}
  rm $(BUILD_DIR_OPKG)/$(OPENSSH_BASE_NAME)/usr/lib/{ssh-keysign,ssh-pkcs11-helper}
endef

OPENSSH_POST_INSTALL_TARGET_HOOKS += OPENSSH_INSTALL_INITSCRIPT
OPENSSH_PRE_BUILD_OPKG_HOOKS += OPENSSH_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package,openssh))
