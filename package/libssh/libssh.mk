#############################################################
#
# libssh
#
#############################################################

LIBSSH_VERSION = 0.5.2
LIBSSH_SITE = http://www.libssh.org/files/0.5
LIBSSH_SOURCE = libssh-$(LIBSSH_VERSION).tar.gz
LIBSSH_INSTALL_STAGING = YES
LIBSSH_INSTALL_TARGET = YES
LIBSSH_BUILD_OPKG = YES
LIBSSH_DEPENDENCIES = host-cmake zlib libgcrypt
LIBSSH_OPKG_DEPENDENCIES = zlib,libgcrypt

LIBSSH_SECTION = network
LIBSSH_DESCRIPTION = A working SSH implementation by means of a library

LIBSSH_CONF_OPT = -DWITH_GCRYPT="ON"

define LIBSSH_CREATE_BUILDDIR 
    mkdir -p $(LIBSSH_DIR)/build
endef

LIBSSH_POST_PATCH_HOOKS += LIBSSH_CREATE_BUILDDIR

define LIBSSH_CONFIGURE_CMDS
    (cd $(LIBSSH_DIR)/build && \
    rm -f CMakeCache.txt && \
    $(HOST_DIR)/usr/bin/cmake $(LIBSSH_DIR) \
	-DCMAKE_TOOLCHAIN_FILE="$(BASE_DIR)/toolchainfile.cmake" \
	-DCMAKE_INSTALL_PREFIX="/usr" \
	$(LIBSSH_CONF_OPT) \
    )
endef

define LIBSSH_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(LIBSSH_MAKE_ENV) $(MAKE) $(LIBSSH_MAKE_OPT) -C $(LIBSSH_DIR)/build
endef

define LIBSSH_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) $(LIBSSH_MAKE_ENV) $(MAKE) $(LIBSSH_MAKE_OPT) DESTDIR=$(STAGING_DIR) install -C $(LIBSSH_DIR)/build
endef

define LIBSSH_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) $(LIBSSH_MAKE_ENV) $(MAKE) $(LIBSSH_MAKE_OPT) DESTDIR=$(TARGET_DIR) install -C $(LIBSSH_DIR)/build
endef

define LIBSSH_BUILD_OPKG_CMDS
    $(TARGET_MAKE_ENV) $(LIBSSH_MAKE_ENV) $(MAKE) $(LIBSSH_MAKE_OPT) DESTDIR=$(BUILD_DIR_OPKG)/libssh-$(LIBSSH_VERSION) install -C $(LIBSSH_DIR)/build
endef
$(eval $(call CMAKETARGETS,package,libssh))
