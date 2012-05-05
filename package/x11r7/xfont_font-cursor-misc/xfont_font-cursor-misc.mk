################################################################################
#
# font-cursor-misc -- No description available
#
################################################################################

XFONT_FONT_CURSOR_MISC_VERSION = 1.0.3
XFONT_FONT_CURSOR_MISC_SOURCE = font-cursor-misc-$(XFONT_FONT_CURSOR_MISC_VERSION).tar.bz2
XFONT_FONT_CURSOR_MISC_SITE = http://xorg.freedesktop.org/releases/individual/font
XFONT_FONT_CURSOR_MISC_AUTORECONF = NO
XFONT_FONT_CURSOR_MISC_INSTALL_STAGING_OPT = DESTDIR=$(STAGING_DIR) install
XFONT_FONT_CURSOR_MISC_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install-data
XFONT_FONT_CURSOR_MISC_BUILD_OPKG_OPT = DESTDIR=$(BUILD_DIR_OPKG)/xfont_font-cursor-misc-$(XFONT_FONT_CURSOR_MISC_VERSION) install-data
XFONT_FONT_CURSOR_MISC_BUILD_OPKG = YES
XFONT_FONT_CURSOR_MISC_NAME_OPKG = font-cursor-misc
XFONT_FONT_CURSOR_MISC_SECTION = x11
XFONT_FONT_CURSOR_MISC_DESCRIPTION = X11 cursor fonts
XFONT_FONT_CURSOR_MISC_CONF_OPT = --with-fontrootdir=/usr/share/fonts
XFONT_FONT_CURSOR_MISC_DEPENDENCIES = xutil_util-macros xfont_font-util host-xfont_font-util host-xapp_mkfontscale host-xapp_mkfontdir host-xapp_bdftopcf
XFONT_FONT_CURSOR_MISC_OPKG_DEPENDENCIES = mkfontdir, mkfontscale

define XFONT_FONT_CURSOR_MISC_RM_FONTS_DIR
    rm $(BUILD_DIR_OPKG)/$(XFONT_FONT_CURSOR_MISC_BASE_NAME)/usr/share/fonts/misc/fonts.dir
endef

define XFONT_FONT_CURSOR_MISC_CP_OPKG_SCRIPTS
    mkdir -p $(BUILD_DIR_OPKG)/$(XFONT_FONT_CURSOR_MISC_BASE_NAME)/CONTROL
    cp $(TOPDIR)/package/x11r7/xfont_font-cursor-misc/opkg-postinst $(BUILD_DIR_OPKG)/$(XFONT_FONT_CURSOR_MISC_BASE_NAME)/CONTROL/postinst
endef

XFONT_FONT_CURSOR_MISC_PRE_BUILD_OPKG_HOOKS += XFONT_FONT_CURSOR_MISC_RM_FONTS_DIR
XFONT_FONT_CURSOR_MISC_PRE_BUILD_OPKG_HOOKS += XFONT_FONT_CURSOR_MISC_CP_OPKG_SCRIPTS
$(eval $(call AUTOTARGETS,package/x11r7,xfont_font-cursor-misc))

