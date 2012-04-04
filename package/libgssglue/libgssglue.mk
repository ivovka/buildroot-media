#############################################################
#
# libgssglue
#
#############################################################

LIBGSSGLUE_VERSION = 0.3
LIBGSSGLUE_SITE = http://www.citi.umich.edu/projects/nfsv4/linux/libgssglue
LIBGSSGLUE_INSTALL_STAGING = YES
LIBGSSGLUE_BUILD_OPKG = YES
LIBGSSGLUE_SECTION = network
LIBGSSGLUE_DESCRIPTION = library which exports a gssapi interface, but doesnt implement any gssapi mechanisms itself

$(eval $(call AUTOTARGETS,package,libgssglue))
