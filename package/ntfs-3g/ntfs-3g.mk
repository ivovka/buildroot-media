#############################################################
#
# ntfs-3g
#
#############################################################

NTFS_3G_VERSION = 2012.1.15
NTFS_3G_SOURCE = ntfs-3g_ntfsprogs-$(NTFS_3G_VERSION).tgz
NTFS_3G_SITE = http://tuxera.com/opensource
NTFS_3G_INSTALL_STAGING = NO
NTFS_3G_BUILD_OPKG = YES
NTFS_3G_SECTION = system
NTFS_3G_DESCRIPTION = NTFS-3G Read Write userspace driver
NTFS_3G_DEPENDENCIES = gnutls libgcrypt
NTFS_3G_OPKG_DEPENDENCIES = gnutls,libgcrypt

NTFS_3G_CONF_OPT = \
  --disable-library \
  --enable-posix-acls \
  --enable-mtab \
  --enable-ntfsprogs \
  --enable-crypto \
  --with-fuse=internal \
  --with-uuid

define NTFS_3G_BUILD_OPKG_CMDS
  mkdir -p $(BUILD_DIR_OPKG)/$(NTFS_3G_BASE_NAME)/usr/bin
  cp $(@D)/src/ntfs-3g $(BUILD_DIR_OPKG)/$(NTFS_3G_BASE_NAME)/usr/bin
  ln -sf ntfs-3g $(BUILD_DIR_OPKG)/$(NTFS_3G_BASE_NAME)/usr/bin/mount.ntfs
  ln -sf ntfs-3g $(BUILD_DIR_OPKG)/$(NTFS_3G_BASE_NAME)/usr/bin/mount.ntfs-3g
endef
$(eval $(call AUTOTARGETS,package,ntfs-3g))
