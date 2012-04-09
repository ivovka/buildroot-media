#############################################################
#
# zip
#
#############################################################

ZIP_VERSION = 30
ZIP_SOURCE = zip$(ZIP_VERSION).tar.gz
ZIP_SITE = $(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/infozip/Zip%203.x%20%28latest%29/3.0
ZIP_INSTALL_STAGING = NO
ZIP_BUILD_OPKG = YES
ZIP_SECTION = compression
ZIP_DESCRIPTION = PKUNZIP compatible compression utility
ZIP_DEPENDENCIES = bzip2
ZIP_OPKG_DEPENDENCIES = bzip2

define ZIP_BUILD_CMDS
  $(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC_NOCCACHE)" CPP=$(TARGET_CROSS)cpp RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" STRIP="$(TARGET_STRIP)" -C $(@D) -f unix/Makefile generic
endef

define ZIP_BUILD_OPKG_CMDS
  mkdir -p $(BUILD_DIR_OPKG)/$(ZIP_BASE_NAME)/usr/bin
  cp $(@D)/zip $(BUILD_DIR_OPKG)/$(ZIP_BASE_NAME)/usr/bin
endef

$(eval $(call GENTARGETS,package,zip))
