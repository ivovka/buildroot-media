################################################################################
#
# font-bitstream-type1 -- No description available
#
################################################################################

XFONT_FONT_BITSTREAM_TYPE1_VERSION = 1.0.3
XFONT_FONT_BITSTREAM_TYPE1_SOURCE = font-bitstream-type1-$(XFONT_FONT_BITSTREAM_TYPE1_VERSION).tar.bz2
XFONT_FONT_BITSTREAM_TYPE1_SITE = http://xorg.freedesktop.org/releases/individual/font
XFONT_FONT_BITSTREAM_TYPE1_AUTORECONF = NO
XFONT_FONT_BITSTREAM_TYPE1_INSTALL_STAGING_OPT = DESTDIR=$(STAGING_DIR) install
XFONT_FONT_BITSTREAM_TYPE1_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install-data
XFONT_FONT_BITSTREAM_TYPE1_BUILD_OPKG_OPT = DESTDIR=$(BUILD_DIR_OPKG)/xfont_font-bitstream-type1-$(XFONT_FONT_BITSTREAM_TYPE1_VERSION) install-data
XFONT_FONT_BITSTREAM_TYPE1_DEPENDENCIES = xfont_font-util host-xfont_font-util host-xapp_mkfontscale host-xapp_mkfontdir host-xapp_bdftopcf
XFONT_FONT_BITSTREAM_TYPE1_OPKG_DEPENDENCIES = mkfontdir, mkfontscale
XFONT_FONT_BITSTREAM_TYPE1_BUILD_OPKG = YES
XFONT_FONT_BITSTREAM_TYPE1_NAME_OPKG = font-bitstream-type1
XFONT_FONT_BITSTREAM_TYPE1_SECTION = x11
XFONT_FONT_BITSTREAM_TYPE1_DESCRIPTION = Bitstream font family.
XFONT_FONT_BITSTREAM_TYPE1_CONF_OPT = --with-fontrootdir=/usr/share/fonts

define XFONT_FONT_BITSTREAM_TYPE1_RM_FONTS_DIR
    rm $(BUILD_DIR_OPKG)/$(XFONT_FONT_BITSTREAM_TYPE1_BASE_NAME)/usr/share/fonts/Type1/{fonts.dir,fonts.scale}
endef

XFONT_FONT_BITSTREAM_TYPE1_PRE_BUILD_OPKG_HOOKS += XFONT_FONT_BITSTREAM_TYPE1_RM_FONTS_DIR
$(eval $(call AUTOTARGETS,package/x11r7,xfont_font-bitstream-type1))

