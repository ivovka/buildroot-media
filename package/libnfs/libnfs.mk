#############################################################
#
# libnfs
#
#############################################################

LIBNFS_VERSION = 0804e67
LIBNFS_SOURCE = libnfs-$(LIBNFS_VERSION).tar.xz
LIBNFS_SITE = http://sources.openelec.tv/devel/
LIBNFS_AUTORECONF = YES
LIBNFS_INSTALL_STAGING = YES
LIBNFS_BUILD_OPKG = YES
LIBNFS_SECTION = network
LIBNFS_DESCRIPTION = client library for accessing NFS shares over a network
LIBNFS_DEPENDENCIES = rpcbind
LIBNFS_OPKG_DEPENDENCIES = rpcbind

LIBNFS_CONF_OPT = \
  --disable-examples \
  --disable-tirpc

$(eval $(call AUTOTARGETS,package,libnfs))
