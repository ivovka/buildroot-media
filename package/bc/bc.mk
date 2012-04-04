#############################################################
#
# bc
#
#############################################################

BC_VERSION = 1.06
BC_SITE = $(BR2_GNU_MIRROR)/bc
BC_BUILD_OPKG = YES
BC_INSTALL_STAGING = NO
BC_SECTION = tools
BC_DESCRIPTION = GNU numeric processing language and a calculator

BC_CONF_OPT = --disable-nls

define BC_OPKG_RM_DC
  rm -f $(BUILD_DIR_OPKG)/$(BC_BASE_NAME)/usr/bin/dc
endef

BC_PRE_BUILD_OPKG_HOOKS += BC_OPKG_RM_DC

$(eval $(call AUTOTARGETS,package,bc))
