#############################################################
#
# jasper
#
#############################################################

JASPER_VERSION = 1.900.1
JASPER_SITE = http://sources.openelec.tv/devel
JASPER_SOURCE = jasper-$(JASPER_VERSION).tar.bz2
JASPER_INSTALL_STAGING = YES
JASPER_INSTALL_TARGET = YES
JASPER_BUILD_OPKG = YES

JASPER_SECTION = graphics
JASPER_DESCRIPTION = JPEG-2000 Part-1 standard (i.e., ISO/IEC 15444-1) implementation

define JASPER_OPKG_RM_BIN
	rm -rf $(BUILD_DIR_OPKG)/$(JASPER_BASE_NAME)/usr/bin
endef

JASPER_PRE_BUILD_OPKG_HOOKS += JASPER_OPKG_RM_BIN

$(eval $(call AUTOTARGETS,package,jasper))
