################################################################################
#
# yajl
#
################################################################################

YAJL_VERSION = 2.0.2
YAJL_SITE = git://github.com/lloyd/yajl.git
YAJL_INSTALL_STAGING = YES
YAJL_BUILD_OPKG = YES

YAJL_SECTION = text
YAJL_PRIORITY = optional
YAJL_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
YAJL_DESCRIPTION = Yet Another JSON Library

$(eval $(call CMAKETARGETS,package,yajl))
