#############################################################
#
# simplejson
#
#############################################################

SIMPLEJSON_VERSION = 2.1.6
SIMPLEJSON_SOURCE = simplejson-$(SIMPLEJSON_VERSION).tar.gz
SIMPLEJSON_SITE = http://pypi.python.org/packages/source/s/simplejson
SIMPLEJSON_INSTALL_STAGING = NO
SIMPLEJSON_BUILD_OPKG = YES
SIMPLEJSON_SECTION = python
SIMPLEJSON_DESCRIPTION = simple, fast, complete, correct and extensible JSON encoder and decoder for Python
SIMPLEJSON_DEPENDENCIES = python host-distribute host-distutilscross
SIMPLEJSON_OPKG_DEPENDENCIES = python,distribute

define SIMPLEJSON_BUILD_CMDS
    (cd $(@D) && \
    PYTHONXCPREFIX="$(STAGING_DIR)/usr" \
    $(TARGET_CONFIGURE_OPTS) python setup.py build --cross-compile bdist_egg --exclude-source-files \
    )
endef

define SIMPLEJSON_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/$(SIMPLEJSON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages
    (PYTHONPATH="$(BUILD_DIR_OPKG)/$(SIMPLEJSON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages" \
    PYTHON_IMAGE_DIR="$(BUILD_DIR_OPKG)/$(SIMPLEJSON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages" \
    $(HOST_DIR)/usr/bin/easy_install --exclude-scripts --zip-ok --no-deps --quiet --prefix=$(BUILD_DIR_OPKG)/$(SIMPLEJSON_BASE_NAME)/usr $(@D)/dist/*.egg \
    )
    rm $(BUILD_DIR_OPKG)/$(SIMPLEJSON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages/site.*
    rm $(BUILD_DIR_OPKG)/$(SIMPLEJSON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages/easy-install.pth
endef

$(eval $(call GENTARGETS,package,simplejson))
