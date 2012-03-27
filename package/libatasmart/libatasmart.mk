#############################################################
#
# libatasmart
#
#############################################################

LIBATASMART_VERSION = 0.17
LIBATASMART_SITE = http://0pointer.de/public
LIBATASMART_DEPENDENCIES = udev
LIBATASMART_INSTALL_STAGING = YES
LIBATASMART_BUILD_OPKG = YES

LIBATASMART_SECTION = system
LIBATASMART_DESCRIPTION = a lean, small and clean implementation of an ATA S.M.A.R.T. reading and parsing library
LIBATASMART_OPKG_DEPENDENCIES = udev

define LIBATASMART_BUILD_HOSTTOOL
    $(HOST_MAKE_ENV) $(LIBATASMART_MAKE_ENV) $(LIBATASMART_MAKE) $(LIBATASMART_MAKE_OPT) CC="$(HOSTCC)" CFLAGS="$(HOST_CFLAGS)" LDFLAGS="$(HOST_LDFLAGS)" -C $(LIBATASMART_SRCDIR) strpool
endef

LIBATASMART_POST_CONFIGURE_HOOKS += LIBATASMART_BUILD_HOSTTOOL
$(eval $(call AUTOTARGETS,package,libatasmart))
