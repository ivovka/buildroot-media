#############################################################
#
# libcap
#
#############################################################

LIBCAP_VERSION = 2.22
LIBCAP_SITE = http://mirror.be.gbxs.net/pub/linux/libs/security/linux-privs/libcap2
LIBCAP_DEPENDENCIES = host-libcap attr
LIBCAP_INSTALL_STAGING = YES
LIBCAP_BUILD_OPKG = YES

LIBCAP_SECTION = devel
LIBCAP_DESCRIPTION = A library for getting and setting POSIX.1e capabilities
LIBCAP_OPKG_DEPENDENCIES = attr

define LIBCAP_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		BUILD_CC="$(HOSTCC)" BUILD_CFLAGS="$(HOST_CFLAGS)"
endef

define LIBCAP_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(STAGING_DIR) \
		RAISE_SETFCAP=no \
		prefix=/usr lib=lib install
endef

define LIBCAP_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) \
		RAISE_SETFCAP=no \
		prefix=/usr lib=lib install
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,capsh getpcaps)
endef

define LIBCAP_BUILD_OPKG_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(BUILD_DIR_OPKG)/libcap-$(LIBCAP_VERSION) \
		RAISE_SETFCAP=no \
		prefix=/usr lib=lib install
	rm -f $(addprefix $(BUILD_DIR_OPKG)/libcap-$(LIBCAP_VERSION)/usr/sbin/,capsh getpcaps)
endef

define HOST_LIBCAP_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) -C $(@D) LIBATTR=no
endef

define HOST_LIBCAP_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) LIBATTR=no DESTDIR=$(HOST_DIR) \
		prefix=/usr lib=lib install
endef

$(eval $(call GENTARGETS,package,libcap))
$(eval $(call GENTARGETS,package,libcap,host))
