#############################################################
#
# parted
#
#############################################################

PARTED_VERSION = 3.1
PARTED_SITE = http://ftp.gnu.org/gnu/parted
PARTED_SOURCE = parted-$(PARTED_VERSION).tar.xz
PARTED_INSTALL_STAGING = YES
PARTED_BUILD_OPKG = YES
PARTED_DEPENDENCIES = util-linux
PARTED_OPKG_DEPENDENCIES = util-linux

PARTED_SECTION = system
PARTED_DESCRIPTION = GNU partition editor

PARTED_CONF_OPT = \
    --disable-device-mapper \
    --without-readline \
    --disable-rpath

define PARTED_INSTALL
    mkdir -p $(1)/usr/bin
    cp $(BUILD_DIR)/$(PARTED_BASE_NAME)/parted/parted $(1)/usr/bin
    cp $(BUILD_DIR)/$(PARTED_BASE_NAME)/partprobe/partprobe $(1)/usr/bin
    mkdir -p $(1)/usr/lib
    cp -P $(BUILD_DIR)/$(PARTED_BASE_NAME)/libparted/.libs/*.so* $(1)/usr/lib
endef

define PARTED_INSTALL_TARGET_CMDS
    $(call PARTED_INSTALL,$(TARGET_DIR))
endef

define PARTED_BUILD_OPKG_CMDS
    $(call PARTED_INSTALL,$(BUILD_DIR_OPKG)/$(PARTED_BASE_NAME))
endef

$(eval $(call AUTOTARGETS,package,parted))
