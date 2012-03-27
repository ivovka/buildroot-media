#############################################################
#
# libass
#
#############################################################

LIBASS_VERSION = 0.9.12
LIBASS_SITE = http://libass.googlecode.com/files
LIBASS_SOURCE = libass-$(LIBASS_VERSION).tar.gz
LIBASS_INSTALL_STAGING = YES
LIBASS_INSTALL_TARGET = YES
LIBASS_BUILD_OPKG = YES

LIBASS_SECTION = libs
LIBASS_PRIORITY = optional
LIBASS_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBASS_DESCRIPTION = a portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format.
LIBASS_OPKG_DEPENDENCIES = freetype,fontconfig,enca

LIBASS_DEPENDENCIES = freetype fontconfig enca
LIBASS_CONF_OPT = --enable-enca

$(eval $(call AUTOTARGETS,package/multimedia,libass))
