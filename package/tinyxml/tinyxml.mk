#############################################################
#
# tinyxml
#
#############################################################

TINYXML_VERSION = 2.6.2
TINYXML_SOURCE = tinyxml_2_6_2.tar.gz
TINYXML_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/tinyxml/$(TINYXML_VERSION)
TINYXML_BUILD_OPKG = YES
TINYXML_SECTION = libs
TINYXML_INSTALL_STAGING = YES
TINYXML_DESCRIPTION = TinyXML is a simple, small, minimal, C++ XML parser

#TINYXML_DEPENDENCIES = openssl xlib_libX11 xlib_libXt

define TINYXML_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
    BUILD_CC="$(HOSTCC)" BUILD_CFLAGS="$(HOST_CFLAGS)" CC="$(TARGET_CC) -fPIC" LD="$(TARGET_CXX)" CXX="$(TARGET_CXX) -fPIC"
    $(TARGET_CXX) $(TARGET_LDFLAGS) -shared -o $(TINYXML_DIR)/libtinyxml.so.$(TINYXML_VERSION) -Wl,-soname,libtinyxml.so.0 $(TINYXML_DIR)/*.o
endef

define TINYXML_INSTALL_STAGING_CMDS
    mkdir -p $(STAGING_DIR)/usr/lib
    mkdir -p $(STAGING_DIR)/usr/include
    cp $(TINYXML_DIR)/tinyxml.h $(STAGING_DIR)/usr/include/
    cp $(TINYXML_DIR)/tinystr.h $(STAGING_DIR)/usr/include/
    cp $(TINYXML_DIR)/libtinyxml.so.$(TINYXML_VERSION) $(STAGING_DIR)/usr/lib/
    ln -sf libtinyxml.so.$(TINYXML_VERSION) $(STAGING_DIR)/usr/lib/libtinyxml.so.0
    ln -sf libtinyxml.so.0 $(STAGING_DIR)/usr/lib/libtinyxml.so
endef

define TINYXML_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/tinyxml-$(TINYXML_VERSION)/usr/lib
    cp $(TINYXML_DIR)/libtinyxml.so.$(TINYXML_VERSION) $(BUILD_DIR_OPKG)/tinyxml-$(TINYXML_VERSION)/usr/lib/
    ln -sf libtinyxml.so.$(TINYXML_VERSION) $(BUILD_DIR_OPKG)/tinyxml-$(TINYXML_VERSION)/usr/lib/libtinyxml.so.0
    ln -sf libtinyxml.so.0 $(BUILD_DIR_OPKG)/tinyxml-$(TINYXML_VERSION)/usr/lib/libtinyxml.so
endef 

$(eval $(call GENTARGETS,package,tinyxml))
