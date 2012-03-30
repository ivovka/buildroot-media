################################################################################
#
# xfont_encodings -- No description available
#
################################################################################

XFONT_ENCODINGS_VERSION = 1.0.4
XFONT_ENCODINGS_SOURCE = encodings-$(XFONT_ENCODINGS_VERSION).tar.bz2
XFONT_ENCODINGS_SITE = http://xorg.freedesktop.org/releases/individual/font
XFONT_ENCODINGS_AUTORECONF = NO
XFONT_ENCODINGS_BUILD_OPKG = YES
XFONT_ENCODINGS_NAME_OPKG = encodings
XFONT_ENCODINGS_SECTION = x11
XFONT_ENCODINGS_DESCRIPTION = X font encodings
XFONT_ENCODINGS_DEPENDENCIES = host-xfont_font-util
XFONT_ENCODINGS_CONF_OPT = --enable-gzip-small-encodings \
    --enable-gzip-large-encodings \
    --with-fontrootdir=/usr/share/fonts

$(eval $(call AUTOTARGETS,package/x11r7,xfont_encodings))
$(eval $(call AUTOTARGETS,package/x11r7,xfont_encodings,host))
