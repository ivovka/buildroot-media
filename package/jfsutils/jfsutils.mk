#############################################################
#
# jfsutils
#
#############################################################
JFSUTILS_VERSION = 1.1.15
JFSUTILS_SITE = http://jfs.sourceforge.net/project/pub
JFSUTILS_SOURCE = jfsutils-$(JFSUTILS_VERSION).tar.gz
JFSUTILS_INSTALL_STAGING = NO
JFSUTILS_INSTALL_TARGET = YES
JFSUTILS_BUILD_OPKG = YES
JFSUTILS_DEPENDENCIES = util-linux

JFSUTILS_SECTION = admin
JFSUTILS_PRIORITY = important
JFSUTILS_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
JFSUTILS_DESCRIPTION = Journaled File System Technology for Linux
JFSUTILS_OPKG_DEPENDENCIES = util-linux

$(eval $(call AUTOTARGETS,package,jfsutils))
