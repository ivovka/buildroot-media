#############################################################
#
# gmp
#
#############################################################

GMP_VERSION = 5.0.4
GMP_SITE = $(BR2_GNU_MIRROR)/gmp
GMP_SOURCE = gmp-$(GMP_VERSION).tar.bz2
GMP_INSTALL_STAGING = YES
GMP_BUILD_OPKG = YES

GMP_SECTION = devel
GMP_DESCRIPTION = GNU Multiple Precision Arithmetic Library

GMP_CONF_OPT = --disable-mpbsd --disable-cxx

$(eval $(call AUTOTARGETS,package,gmp))
$(eval $(call AUTOTARGETS,package,gmp,host))
