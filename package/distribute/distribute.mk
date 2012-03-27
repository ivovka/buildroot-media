#############################################################
#
# distribute
#
#############################################################
DISTRIBUTE_VERSION = 0.6.19
DISTRIBUTE_SOURCE = distribute-$(DISTRIBUTE_VERSION).tar.gz
DISTRIBUTE_SITE = http://pypi.python.org/packages/source/d/distribute
DISTRIBUTE_INSTALL_STAGING = YES
DISTRIBUTE_INSTALL_TARGET = YES
DISTRIBUTE_BUILD_OPKG = YES
DISTRIBUTE_SECTION = python
DISTRIBUTE_DESCRIPTION = A collection of enhancements to the Python distutils
DISTRIBUTE_OPKG_DEPENDENCIES = python
DISTRIBUTE_DEPENDENCIES = host-python python
#DISTRIBUTE_CONF_ENV = 
#DISTRIBUTE_CONF_OPT = 
define DISTRIBUTE_BUILD_CMDS
    (cd $(@D) && \
    $(HOST_MAKE_ENV) python setup.py install --prefix=$(HOST_DIR)/usr \
    )
endef

#define DISTRIBUTE_BUILD_OPKG_CMDS
#    (PYTHONPATH="$(TARGET_DIR)/usr/lib/python-$(PYTHON_VERSION_MAJOR)" \
#    PYTHON_IMAGE_DIR="$(TARGET_DIR)/usr/lib/python-$(PYTHON_VERSION_MAJOR)/site-packages" \
#    $(HOST_DIR)/usr/bin/easy_install --exclude-scripts --zip-ok --quiet --prefix=$(BUILD_DIR_OPKG)/$(DISTRIBUTE_BASE_NAME)/usr $(@D) \
#    )
#endef

$(eval $(call GENTARGETS,package,distribute))
