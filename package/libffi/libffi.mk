#############################################################
#
# libffi
#
#############################################################

LIBFFI_VERSION = 3.0.10
LIBFFI_SITE    = ftp://sources.redhat.com/pub/libffi/

LIBFFI_INSTALL_STAGING = YES
LIBFFI_BUILD_OPKG = YES
LIBFFI_OPKG_DEPENDENCIES = libc

LIBFFI_SECTION = devel
LIBFFI_PRIORITY = optional
LIBFFI_DESCRIPTION = Foreign Function Interface Library

# Move the headers to the usual location, and adjust the .pc file
# accordingly
define LIBFFI_MOVE_STAGING_HEADERS
	mv $(STAGING_DIR)/usr/lib/libffi-*/include/*.h $(STAGING_DIR)/usr/include/
	sed -i '/^includedir.*/d' $(STAGING_DIR)/usr/lib/pkgconfig/libffi.pc
	sed -i 's/-I$${includedir}//g' $(STAGING_DIR)/usr/lib/pkgconfig/libffi.pc
	rm -rf $(TARGET_DIR)/usr/lib/libffi-*
endef

LIBFFI_POST_INSTALL_STAGING_HOOKS += LIBFFI_MOVE_STAGING_HEADERS

define LIBFFI_RM_OPKG_HEADERS
	rm -rf $(BUILD_DIR_OPKG)/libffi-$(LIBFFI_VERSION)/usr/lib/libffi-*
endef

LIBFFI_PRE_BUILD_OPKG_HOOKS += LIBFFI_RM_OPKG_HEADERS

# Similar for target headers
define LIBFFI_MOVE_TARGET_HEADERS
	install -d $(TARGET_DIR)/usr/include/
	mv $(TARGET_DIR)/usr/lib/libffi-*/include/*.h $(TARGET_DIR)/usr/include/
	sed -i '/^includedir.*/d' $(TARGET_DIR)/usr/lib/pkgconfig/libffi.pc
	rm -rf $(TARGET_DIR)/usr/lib/libffi-*
endef

LIBFFI_POST_INSTALL_TARGET_HOOKS += LIBFFI_MOVE_TARGET_HEADERS

HOST_LIBFFI_CONF_OPT = \
	--enable-structs \
	--enable-raw-api \
	--disable-purify-safety

$(eval $(call AUTOTARGETS,package,libffi))
$(eval $(call AUTOTARGETS,package,libffi,host))
