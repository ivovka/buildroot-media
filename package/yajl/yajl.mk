################################################################################
#
# yajl
#
################################################################################

YAJL_VERSION = 2.0.4
YAJL_SITE = git://github.com/lloyd/yajl.git
YAJL_INSTALL_STAGING = YES
YAJL_BUILD_OPKG = YES

YAJL_SECTION = text
YAJL_DESCRIPTION = Yet Another JSON Library

define YAJL_OPKG_RM_BIN
	rm -rf $(BUILD_DIR_OPKG)/$(YAJL_BASE_NAME)/usr/{bin,share}
endef

YAJL_PRE_BUILD_OPKG_HOOKS += YAJL_OPKG_RM_BIN

$(eval $(call CMAKETARGETS,package,yajl))
