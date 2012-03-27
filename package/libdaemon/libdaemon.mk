#############################################################
#
# libdaemon (UNIX daemon library)
#
#############################################################

LIBDAEMON_VERSION = 0.14
LIBDAEMON_SOURCE = libdaemon-$(LIBDAEMON_VERSION).tar.gz
LIBDAEMON_SITE = http://0pointer.de/lennart/projects/libdaemon/
LIBDAEMON_AUTORECONF = NO
LIBDAEMON_INSTALL_STAGING = YES
LIBDAEMON_BUILD_OPKG = YES

LIBDAEMON_SECTION = other
LIBDAEMON_PRIORITY = optional
LIBDAEMON_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBDAEMON_DESCRIPTION = A lightweight C library which eases the writing of UNIX daemon

LIBDAEMON_CONF_ENV = ac_cv_func_setpgrp_void=no
LIBDAEMON_CONF_OPT = --disable-lynx

LIBDAEMON_DEPENDENCIES = host-pkg-config

$(eval $(call AUTOTARGETS,package,libdaemon))
