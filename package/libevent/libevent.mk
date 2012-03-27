#############################################################
#
# libevent
#
#############################################################
LIBEVENT_VERSION = 2.0.16
LIBEVENT_SOURCE = libevent-$(LIBEVENT_VERSION)-stable.tar.gz
LIBEVENT_SITE = http://monkey.org/~provos/

LIBEVENT_AUTORECONF = NO
LIBEVENT_INSTALL_STAGING = YES
LIBEVENT_INSTALL_TARGET = YES
LIBEVENT_BUILD_OPKG = YES

LIBEVENT_SECTION = libs
LIBEVENT_DESCRIPTION = Userspace library for handling asynchronous notifications

define LIBEVENT_REMOVE_PYSCRIPT
	rm $(TARGET_DIR)/usr/bin/event_rpcgen.py
endef

define LIBEVENT_REMOVE_BIN
	rm -rf $(BUILD_DIR_OPKG)/$(LIBEVENT_BASE_NAME)/usr/bin
endef

LIBEVENT_PRE_BUILD_OPKG_HOOKS += LIBEVENT_REMOVE_BIN

# libevent installs a python script to target - get rid of it if we
# don't have python support enabled
ifneq ($(BR2_PACKAGE_PYTHON),y)
LIBEVENT_POST_INSTALL_TARGET_HOOKS += LIBEVENT_REMOVE_PYSCRIPT
endif

$(eval $(call AUTOTARGETS,package,libevent))
