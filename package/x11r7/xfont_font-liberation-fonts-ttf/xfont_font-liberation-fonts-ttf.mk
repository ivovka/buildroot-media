################################################################################
#
# font-liberation-fonts-ttf
#
################################################################################

XFONT_FONT_LIBERATION_FONTS_TTF_VERSION = 1.07.2
XFONT_FONT_LIBERATION_FONTS_TTF_SOURCE = liberation-fonts-ttf-$(XFONT_FONT_LIBERATION_FONTS_TTF_VERSION).tar.gz
XFONT_FONT_LIBERATION_FONTS_TTF_SITE = https://fedorahosted.org/releases/l/i/liberation-fonts
XFONT_FONT_LIBERATION_FONTS_TTF_AUTORECONF = NO
XFONT_FONT_LIBERATION_FONTS_TTF_INSTALL_STAGING = NO
XFONT_FONT_LIBERATION_FONTS_TTF_BUILD_OPKG = YES
XFONT_FONT_LIBERATION_FONTS_TTF_NAME_OPKG = liberation-fonts-ttf
XFONT_FONT_LIBERATION_FONTS_TTF_SECTION = x11
XFONT_FONT_LIBERATION_FONTS_TTF_DESCRIPTION = High quality open-sourced vector fonts
XFONT_FONT_LIBERATION_FONTS_TTF_DEPENDENCIES = xutil_util-macros
XFONT_FONT_LIBERATION_FONTS_TTF_OPKG_DEPENDENCIES = mkfontdir,mkfontscale
XFONT_FONT_LIBERATION_FONTS_TTF_FONTDIR=$(BUILD_DIR_OPKG)/$(XFONT_FONT_LIBERATION_FONTS_TTF_BASE_NAME)/usr/share/fonts/liberation

define XFONT_FONT_LIBERATION_FONTS_TTF_BUILD_OPKG_CMDS
    mkdir -p $(XFONT_FONT_LIBERATION_FONTS_TTF_FONTDIR)
    cp $(@D)/*.ttf $(XFONT_FONT_LIBERATION_FONTS_TTF_FONTDIR)
    $(HOST_DIR)/usr/bin/mkfontdir $(XFONT_FONT_LIBERATION_FONTS_TTF_FONTDIR)
    $(HOST_DIR)/usr/bin/mkfontscale $(XFONT_FONT_LIBERATION_FONTS_TTF_FONTDIR)
endef

$(eval $(call GENTARGETS,package/x11r7,xfont_font-liberation-fonts-ttf))

