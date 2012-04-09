#############################################################
#
# libtirpc
#
#############################################################

LIBTIRPC_VERSION = 0.2.2
LIBTIRPC_SOURCE = libtirpc-$(LIBTIRPC_VERSION).tar.bz2
LIBTIRPC_SITE = $(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/project/libtirpc/libtirpc/$(LIBTIRPC_VERSION)
LIBTIRPC_AUTORECONF = YES
LIBTIRPC_INSTALL_STAGING = YES
LIBTIRPC_BUILD_OPKG = YES
LIBTIRPC_SECTION = network
LIBTIRPC_DESCRIPTION = Transport Independent RPC Library
LIBTIRPC_DEPENCENCIES = libgssglue
LIBTIRPC_OPKG_DEPENDENCIES = libgssglue

LIBTIRPC_CONF_OPT = --enable-gss

$(eval $(call AUTOTARGETS,package,libtirpc))
