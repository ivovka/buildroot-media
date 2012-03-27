LIRC_VERSION = 0.9.0
LIRC_SOURCE = lirc-$(LIRC_VERSION).tar.bz2
LIRC_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/lirc
LIRC_INSTALL_STAGING = NO
LIRC_BUILD_OPKG = YES
LIRC_SECTION = remote
LIRC_DESCRIPTION = Linux Infrared Remote Control
LIRC_CONF_ENV = ac_cv_path_LIBUSB_CONFIG= \
    ac_cv_func_forkpty=no \
    ac_cv_lib_util_forkpty=no \
    MAKEFLAGS=-j1

LIRC_CONF_OPT = --enable-sandboxed \
    --without-x \
    --with-driver=devinput \
    --with-syslog=LOG_DAEMON \
    --with-kerneldir=$(BUILD_DIR)/linux-$(LINUX_VERSION)

LIRC_MAKE = $(MAKE1)

$(eval $(call AUTOTARGETS,package,lirc))
