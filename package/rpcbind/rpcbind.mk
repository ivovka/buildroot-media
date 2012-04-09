#############################################################
#
# rpcbind
#
#############################################################

RPCBIND_VERSION = 0.2.0
RPCBIND_SOURCE = rpcbind-$(RPCBIND_VERSION).tar.bz2
RPCBIND_SITE = $(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/rpcbind/rpcbind/$(RPCBIND_VERSION)
RPCBIND_AUTORECONF = YES
RPCBIND_INSTALL_STAGING = YES
RPCBIND_BUILD_OPKG = YES
RPCBIND_SECTION = network
RPCBIND_DESCRIPTION = a server that converts RPC program numbers into universal addresses
RPCBIND_DEPENDENCIES = libtirpc
RPCBIND_OPKG_DEPENDENCIES = libtirpc

RPCBIND_CONF_OPT = \
  --enable-warmstarts \
  --disable-libwrap \
  --with-statedir=/tmp \
  --with-rpcuser=root

$(eval $(call AUTOTARGETS,package,rpcbind))
