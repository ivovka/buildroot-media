#############################################################
#
# sg3_utils
#
#############################################################

SG3_UTILS_VERSION = 1.30
SG3_UTILS_SITE = http://sg.danny.cz/sg/p
SG3_UTILS_SOURCE = sg3_utils-$(SG3_UTILS_VERSION).tar.bz2
SG3_UTILS_INSTALL_STAGING = YES
SG3_UTILS_BUILD_OPKG = YES

SG3_UTILS_NAME_OPKG = sg3-utils
SG3_UTILS_SECTION = system
SG3_UTILS_DESCRIPTION = a package of utilities for accessing devices that use SCSI command sets.

define SG3_UTILS_RM_BIN
    rm -rf $(BUILD_DIR_OPKG)/$(SG3_UTILS_BASE_NAME)/usr/bin
endef

SG3_UTILS_PRE_BUILD_OPKG_HOOKS += SG3_UTILS_RM_BIN

$(eval $(call AUTOTARGETS,package,sg3_utils))
