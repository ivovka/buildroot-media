#############################################################
#
# zlib
#
#############################################################
ZLIB_VERSION:=1.2.6
ZLIB_SOURCE:=zlib-$(ZLIB_VERSION).tar.bz2
ZLIB_SITE:=http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/libpng
ZLIB_INSTALL_STAGING=YES

ZLIB_BUILD_OPKG = YES
ZLIB_SECTION = libs
ZLIB_PRIORITY = required
ZLIB_DESCRIPTION = Standard (de)compression library.  Used by things like gzip and libpng.

# Actually zlib does not depends on nasm nor on yasm, but we need to add that assemblers to the toolchain at the early stage.
ZLIB_DEPENDENCIES = host-nasm host-yasm
ZLIB_OPKG_DEPENDENCIES = libc

ifeq ($(BR2_PREFER_STATIC_LIB),y)
ZLIB_PIC :=
ZLIB_SHARED := --static
else
ZLIB_PIC := -fPIC
ZLIB_SHARED := --shared
endif

define ZLIB_CONFIGURE_CMDS
	(cd $(@D); rm -rf config.cache; \
		$(TARGET_CONFIGURE_ARGS) \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) $(ZLIB_PIC)" \
		./configure \
		$(ZLIB_SHARED) \
		--prefix=/usr \
	)
endef

define HOST_ZLIB_CONFIGURE_CMDS
	(cd $(@D); rm -rf config.cache; \
		$(HOST_CONFIGURE_ARGS) \
		$(HOST_CONFIGURE_OPTS) \
		./configure \
		--prefix="$(HOST_DIR)/usr" \
		--sysconfdir="$(HOST_DIR)/etc" \
	)
endef

define ZLIB_BUILD_CMDS
	$(MAKE1) -C $(@D)
endef

define HOST_ZLIB_BUILD_CMDS
	$(MAKE1) -C $(@D)
endef

define ZLIB_INSTALL_STAGING_CMDS
	$(MAKE1) -C $(@D) DESTDIR=$(STAGING_DIR) LDCONFIG=true install
endef

define ZLIB_INSTALL_TARGET_CMDS
	$(MAKE1) -C $(@D) DESTDIR=$(TARGET_DIR) LDCONFIG=true install
endef

define ZLIB_BUILD_OPKG_CMDS
	mkdir -p $(BUILD_DIR_OPKG)/zlib-$(ZLIB_VERSION)
	$(MAKE1) -C $(@D) DESTDIR=$(BUILD_DIR_OPKG)/zlib-$(ZLIB_VERSION) LDCONFIG=true install
endef

define HOST_ZLIB_INSTALL_CMDS
	$(MAKE1) -C $(@D) LDCONFIG=true install
endef

define ZLIB_CLEAN_CMDS
	-$(MAKE1) -C $(@D) clean
endef

define ZLIB_UNINSTALL_STAGING_CMDS
	$(MAKE1) -C $(@D) DESTDIR=$(STAGING_DIR) uninstall
endef

define ZLIB_UNINSTALL_TARGET_CMDS
	$(MAKE1) -C $(@D) DESTDIR=$(TARGET_DIR) uninstall
endef

define HOST_ZLIB_UNINSTALL_TARGET_CMDS
	$(MAKE1) -C $(@D) uninstall
endef

$(eval $(call GENTARGETS,package,zlib))
$(eval $(call GENTARGETS,package,zlib,host))
