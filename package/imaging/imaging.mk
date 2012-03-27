#############################################################
#
# imaging
#
#############################################################
IMAGING_VERSION = 1.1.7
IMAGING_SOURCE = Imaging-$(IMAGING_VERSION).tar.gz
IMAGING_SITE = http://effbot.org/downloads
IMAGING_INSTALL_STAGING = NO
IMAGING_INSTALL_TARGET = YES
IMAGING_BUILD_OPKG = YES
IMAGING_SECTION = python
IMAGING_DESCRIPTION = Imaging handling/processing for Python
IMAGING_OPKG_DEPENDENCIES = python,freetype,$(call qstrip,$(BR2_JPEG_LIBRARY))
IMAGING_DEPENDENCIES = host-python python distribute distutilscross zlib freetype $(call qstrip,$(BR2_JPEG_LIBRARY))

IMAGINGXCPREFIX=$(STAGING_DIR)/usr
IMAGING_LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/usr/lib -L$(STAGING_DIR)/lib"

#IMAGING_CONF_ENV = 
#IMAGING_CONF_OPT = 
define IMAGING_BUILD_CMDS
    (cd $(@D) && \
    $(HOST_MAKE_ENV) PYTHONXCPREFIX=$(IMAGINGXCPREFIX) LDFLAGS=$(IMAGING_LDFLAGS) python setup.py build --cross-compile && \
    $(HOST_MAKE_ENV) PYTHONXCPREFIX=$(IMAGINGXCPREFIX) LDFLAGS=$(IMAGING_LDFLAGS) python setup.py install -O1 --skip-build --prefix /usr --root .install \
    )
    find $(@D)/.install -name "*.py" -exec rm -rf "{}" ";"
    find $(@D)/.install -name "*.pyo" -exec rm -rf "{}" ";"
    rm -rf $(@D)/.install/usr/bin
endef

define IMAGING_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/$(IMAGING_BASE_NAME)
    cp -PR $(@D)/.install/* $(BUILD_DIR_OPKG)/$(IMAGING_BASE_NAME)
endef

$(eval $(call GENTARGETS,package,imaging))
