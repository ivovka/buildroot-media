#############################################################
#
# udisks
#
#############################################################

UDISKS_VERSION = 1.0.4
UDISKS_SITE = http://hal.freedesktop.org/releases
UDISKS_INSTALL_STAGING = NO
UDISKS_BUILD_OPKG = YES
UDISKS_DEPENDENCIES = sg3_utils libglib2 udev dbus dbus-glib parted lvm2 polkit libatasmart
UDISKS_OPKG_DEPENDENCIES = sg3-utils,udev,libglib2,dbus,dbus-glib,parted,lvm2,polkit,libatasmart

UDISKS_SECTION = system
UDISKS_DESCRIPTION = a modular hardware abstraction layer designed for use in Linux systems that is designed to simplify device management.

UDISKS_CONF_OPT = \
    --libexecdir=/usr/lib/udisks \
    --localstatedir=/var \
    --disable-static \
    --enable-shared \
    --disable-man-pages \
    --disable-gtk-doc \
    --enable-gtk-doc-html \
    --enable-gtk-doc-pdf \
    --disable-lvm2 \
    --disable-dmmp \
    --disable-remote-access \
    --disable-nls

# remove (possibly) buggy rule that leads to segfault
define UDISKS_RM_BUGGY_RULE
    -rm $(1)/lib/udev/rules.d/80-udisks.rules
endef

define UDISKS_RM_BUGGY_RULE_TARGET
    $(call UDISKS_RM_BUGGY_RULE,$(TARGET_DIR))
endef

define UDISKS_RM_BUGGY_RULE_OPKG
    $(call UDISKS_RM_BUGGY_RULE,$(BUILD_DIR_OPKG)/$(UDISKS_BASE_NAME))
endef

define UDISKS_OPKG_CLEANUP
  rm -rf $(BUILD_DIR_OPKG)/$(UDISKS_BASE_NAME)/etc/profile.d
  rm -rf $(BUILD_DIR_OPKG)/$(UDISKS_BASE_NAME)/usr/share/locale
  rm -rf $(BUILD_DIR_OPKG)/$(UDISKS_BASE_NAME)/usr/share/pkgconfig
endef

UDISKS_PRE_BUILD_OPKG_HOOKS += UDISKS_OPKG_CLEANUP

UDISKS_POST_INSTALL_TARGET_HOOKS += UDISKS_RM_BUGGY_RULE_TARGET
UDISKS_PRE_BUILD_OPKG_HOOKS += UDISKS_RM_BUGGY_RULE_OPKG

$(eval $(call AUTOTARGETS,package,udisks))
