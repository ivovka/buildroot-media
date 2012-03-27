#############################################################
#
# distutilscross
#
#############################################################
DISTUTILSCROSS_VERSION = 0.1
DISTUTILSCROSS_SOURCE = distutilscross-$(DISTUTILSCROSS_VERSION).tar.gz
DISTUTILSCROSS_SITE = http://pypi.python.org/packages/source/d/distutilscross
DISTUTILSCROSS_INSTALL_STAGING = NO
DISTUTILSCROSS_INSTALL_TARGET = YES
DISTUTILSCROSS_BUILD_OPKG = NO
DISTUTILSCROSS_DEPENDENCIES = host-python python distribute
#DISTUTILSCROSS_CONF_ENV = 
#DISTUTILSCROSS_CONF_OPT = 
define DISTUTILSCROSS_BUILD_CMDS
    (cd $(@D) && \
    $(HOST_MAKE_ENV) python setup.py install --prefix=$(HOST_DIR)/usr \
    )
endef
$(eval $(call GENTARGETS,package,distutilscross))
