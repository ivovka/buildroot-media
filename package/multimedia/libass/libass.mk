#############################################################
#
# libass
#
#############################################################

LIBASS_VERSION = 0.10.0
LIBASS_SITE = http://libass.googlecode.com/files
LIBASS_SOURCE = libass-$(LIBASS_VERSION).tar.gz
LIBASS_INSTALL_STAGING = YES
LIBASS_INSTALL_TARGET = YES
LIBASS_BUILD_OPKG = YES
LIBASS_DEPENDENCIES = freetype fontconfig enca fribidi
LIBASS_OPKG_DEPENDENCIES = freetype,fontconfig,enca,fribidi

LIBASS_SECTION = libs
LIBASS_DESCRIPTION = a portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format.

LIBASS_CONF_OPT = \
  --enable-enca \
  --disable-test \
  --enable-fontconfig \
  --disable-harfbuzz

$(eval $(call AUTOTARGETS,package/multimedia,libass))
