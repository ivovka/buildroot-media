#############################################################
#
# xkeyboard-config
#
#############################################################
XKEYBOARD_CONFIG_VERSION = 2.5.1
XKEYBOARD_CONFIG_SOURCE = xkeyboard-config-$(XKEYBOARD_CONFIG_VERSION).tar.bz2
XKEYBOARD_CONFIG_SITE = http://www.x.org/releases/individual/data/
XKEYBOARD_CONFIG_AUTORECONF = NO
XKEYBOARD_CONFIG_INSTALL_STAGING = NO
XKEYBOARD_CONFIG_INSTALL_TARGET = YES
XKEYBOARD_CONFIG_DEPENDENCIES = host-intltool host-xapp_xkbcomp xutil_util-macros xapp_xkbcomp
XKEYBOARD_CONFIG_BUILD_OPKG = YES
XKEYBOARD_CONFIG_SECTION = x11
XKEYBOARD_CONFIG_DESCRIPTION = X keyboard extension data files


XKEYBOARD_CONFIG_CONF_OPT = GMSGFMT=/usr/bin/msgfmt \
    --with-xkb-base=/usr/share/X11/xkb \
    --without-xkb-rules-symlink

define XKEYBOARD_CONFIG_OPKG_CLEANUP
  rm -rf $(BUILD_DIR_OPKG)/$(XKEYBOARD_CONFIG_BASE_NAME)/usr/share/{locale,pkgconfig}
endef

XKEYBOARD_CONFIG_PRE_BUILD_OPKG_HOOKS += XKEYBOARD_CONFIG_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package/x11r7,xkeyboard-config))

