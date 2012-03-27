################################################################################
#
# wavpack
#
################################################################################

WAVPACK_VERSION = 4.60.1
WAVPACK_SITE = http://www.wavpack.com
WAVPACK_SOURCE = wavpack-$(WAVPACK_VERSION).tar.bz2
WAVPACK_INSTALL_STAGING = YES
WAVPACK_BUILD_OPKG = YES

WAVPACK_SECTION = libs
WAVPACK_PRIORITY = optional
WAVPACK_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
WAVPACK_DESCRIPTION = a completely open audio compression format

ifneq ($(BR2_ENABLE_LOCALE),y)
WAVPACK_DEPENDENCIES += libiconv
endif

$(eval $(call AUTOTARGETS,package/multimedia,wavpack))
