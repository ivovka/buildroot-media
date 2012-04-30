#############################################################
#
# configobj
#
#############################################################
CONFIGOBJ_VERSION = 4.7.2
CONFIGOBJ_SOURCE = configobj-$(CONFIGOBJ_VERSION).tar.gz
CONFIGOBJ_SITE = http://pypi.python.org/packages/source/c/configobj
CONFIGOBJ_INSTALL_STAGING = NO
CONFIGOBJ_INSTALL_TARGET = YES
CONFIGOBJ_BUILD_OPKG = YES
CONFIGOBJ_SECTION = python
CONFIGOBJ_DESCRIPTION = a simple but powerful config file reader and writer
CONFIGOBJ_OPKG_DEPENDENCIES = python
CONFIGOBJ_DEPENDENCIES = host-python python distribute distutilscross host-distutilscross

CONFIGOBJXCPREFIX=$(STAGING_DIR)/usr
CONFIGOBJ_LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/usr/lib -L$(STAGING_DIR)/lib"

define CONFIGOBJ_BUILD_CMDS
    (cd $(@D) && \
    $(HOST_MAKE_ENV) PYTHONXCPREFIX=$(CONFIGOBJXCPREFIX) LDFLAGS=$(CONFIGOBJ_LDFLAGS) python setup.py build --cross-compile bdist_egg --exclude-source-files \
    )
endef

$(eval $(call GENTARGETS,package,configobj))
