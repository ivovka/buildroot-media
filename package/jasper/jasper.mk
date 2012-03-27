#############################################################
#
# jasper
#
#############################################################

JASPER_VERSION = 1.900.1
JASPER_SITE = http://sources.openelec.tv/devel
JASPER_SOURCE = jasper-$(JASPER_VERSION).tar.bz2
JASPER_INSTALL_STAGING = YES
JASPER_INSTALL_TARGET = YES
JASPER_BUILD_OPKG = YES

JASPER_SECTION = graphics
JASPER_PRIORITY = optional
JASPER_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
JASPER_DESCRIPTION = JPEG-2000 Part-1 standard (i.e., ISO/IEC 15444-1) implementation

$(eval $(call AUTOTARGETS,package,jasper))
