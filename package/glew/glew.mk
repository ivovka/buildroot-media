#############################################################
#
# GLEW
#
#############################################################
GLEW_VERSION:=1.6.0
GLEW_SOURCE:=glew-$(GLEW_VERSION).tgz
GLEW_SITE:=http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/glew/glew/$(GLEW_VERSION)
GLEW_BUILD_OPKG = YES
GLEW_SECTION = graphics
GLEW_DESCRIPTION = The OpenGL Extension Wrangler Library
GLEW_OPKG_DEPENDENCIES = libx11,libxext,libxi,libxmu,mesa
GLEW_DEPENDENCIES = xlib_libX11 xlib_libXext xlib_libXi xlib_libXmu mesa3d
GLEW_INSTALL_STAGING = YES
GLEW_INSTALL_TARGET = YES
GLEW_AUTORECONF = NO

define GLEW_BUILD_CMDS
    $(TARGET_MAKE_ENV) \
    $(MAKE) -C $(@D) \
    GLEW_DEST="/usr" CC="$(TARGET_CC)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" LD="$(TARGET_CC)" \
    POPT="$(TARGET_CFLAGS)" LDFLAGS.EXTRA="$(TARGET_LDFLAGS)"
endef

define GLEW_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) \
    $(TARGET_CONFIGURE_OPTS) \
    $(MAKE) -C $(@D) \
    GLEW_DEST="$(STAGING_DIR)/usr" install
endef

define GLEW_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) \
    $(TARGET_CONFIGURE_OPTS) \
    $(MAKE) -C $(@D) \
    GLEW_DEST="$(TARGET_DIR)/usr" install
endef

define GLEW_BUILD_OPKG_CMDS
    $(TARGET_MAKE_ENV) \
    $(TARGET_CONFIGURE_OPTS) \
    $(MAKE) -C $(@D) \
    GLEW_DEST="$(BUILD_DIR_OPKG)/glew-$(GLEW_VERSION)/usr" install
endef

define GLEW_CLEAN_CMDS
endef

$(eval $(call GENTARGETS,package,glew))
