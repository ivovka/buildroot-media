################################################################################
#
# font-misc-misc -- No description available
#
################################################################################

XFONT_FONT_MISC_MISC_VERSION = 1.1.2
XFONT_FONT_MISC_MISC_SOURCE = font-misc-misc-$(XFONT_FONT_MISC_MISC_VERSION).tar.bz2
XFONT_FONT_MISC_MISC_SITE = http://xorg.freedesktop.org/releases/individual/font
XFONT_FONT_MISC_MISC_AUTORECONF = NO
XFONT_FONT_MISC_MISC_INSTALL_STAGING_OPT = DESTDIR=$(STAGING_DIR) install
XFONT_FONT_MISC_MISC_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install-data
XFONT_FONT_MISC_MISC_BUILD_OPKG_OPT = DESTDIR=$(BUILD_DIR_OPKG)/xfont_font-misc-misc-$(XFONT_FONT_MISC_MISC_VERSION) install-data
XFONT_FONT_MISC_MISC_DEPENDENCIES = xutil_util-macros xfont_font-cursor-misc xfont_font-util host-xfont_font-util host-xapp_mkfontscale host-xapp_mkfontdir host-xapp_bdftopcf
XFONT_FONT_MISC_MISC_BUILD_OPKG = YES
XFONT_FONT_MISC_MISC_NAME_OPKG = font-misc-misc
XFONT_FONT_MISC_MISC_SECTION = x11
XFONT_FONT_MISC_MISC_DESCRIPTION = A misc. public domain font
XFONT_FONT_MISC_MISC_OPKG_DEPENDENCIES = font-cursor-misc,font-util,mkfontscale,mkfontdir
XFONT_FONT_MISC_MISC_CONF_OPT = \
    --with-fontrootdir=/usr/share/fonts \
    --disable-silent-rules \
    --enable-iso8859-1 \
    --enable-iso8859-2 \
    --disable-iso8859-3 \
    --disable-iso8859-4 \
    --enable-iso8859-5 \
    --disable-iso8859-6 \
    --enable-iso8859-7 \
    --enable-iso8859-8 \
    --enable-iso8859-9 \
    --disable-iso8859-10 \
    --disable-iso8859-11 \
    --disable-iso8859-12 \
    --disable-iso8859-13 \
    --enable-iso8859-14 \
    --enable-iso8859-15 \
    --disable-iso8859-16 \
    --enable-koi8-r \
    --disable-jisx0201


define XFONT_FONT_MISC_MISC_MAPFILES_PATH_FIX
	$(SED) 's|UTIL_DIR = |UTIL_DIR = $(STAGING_DIR)|' $(@D)/Makefile
endef

define XFONT_FONT_MISC_MISC_BUILD_OPKG_CMDS
  mkdir -p $(BUILD_DIR_OPKG)/$(XFONT_FONT_MISC_MISC_BASE_NAME)/usr/share/fonts/misc
  cp $(@D)/6x13-ISO8859-1.pcf.gz $(BUILD_DIR_OPKG)/$(XFONT_FONT_MISC_MISC_BASE_NAME)/usr/share/fonts/misc
endef

XFONT_FONT_MISC_MISC_POST_CONFIGURE_HOOKS += XFONT_FONT_MISC_MISC_MAPFILES_PATH_FIX

$(eval $(call AUTOTARGETS,package/x11r7,xfont_font-misc-misc))

