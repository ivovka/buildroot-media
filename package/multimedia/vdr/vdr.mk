#############################################################
#
# vdr
#
#############################################################
VDR_VERSION = 1.7.27
VDR_SITE = ftp://ftp.tvdr.de/vdr/Developer
VDR_SOURCE = vdr-$(VDR_VERSION).tar.bz2

VDR_SC_SITE = http://85.17.209.13:6100
VDR_SC_VERSION = 35714d9890a9
VDR_SC_SOURCE = sc-$(VDR_SC_VERSION).tar.bz2

VDR_XVDR_SITE = https://nodeload.github.com
VDR_XVDR_VERSION = 0.9.5-39-gb62ccbd
VDR_XVDR_SOURCE = pipelka-vdr-plugin-xvdr-$(VDR_XVDR_VERSION).tar.gz

VDR_IPTV_SITE = http://www.saunalahti.fi/~rahrenbe/vdr/iptv/files
VDR_IPTV_VERSION = 1.0.0
VDR_IPTV_SOURCE = vdr-iptv-$(VDR_IPTV_VERSION).tgz

VDR_XINELIBOUTPUT_VERSION = 20120511
VDR_XINELIBOUTPUT_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/xineliboutput/xineliboutput/vdr-xineliboutput-$(VDR_XINELIBOUTPUT_VERSION)
VDR_XINELIBOUTPUT_SOURCE = vdr-xineliboutput-$(VDR_XINELIBOUTPUT_VERSION).tar.gz

VDR_INSTALL_STAGING = NO
VDR_INSTALL_TARGET = YES
VDR_BUILD_OPKG = YES
VDR_SECTION = multimedia
VDR_DESCRIPTION = Video Disk Recorder
VDR_OPKG_DEPENDENCIES = libcap,fontconfig,freetype,$(call qstrip,$(BR2_JPEG_LIBRARY))
VDR_DEPENDENCIES = libcap fontconfig freetype $(call qstrip,$(BR2_JPEG_LIBRARY))

define VDR_SC_DOWNLOAD
    $(call DOWNLOAD,$(VDR_SC_SITE),$(VDR_SC_SOURCE))
endef
define VDR_XVDR_DOWNLOAD
    $(call DOWNLOAD,$(VDR_XVDR_SITE),$(VDR_XVDR_SOURCE))
endef
define VDR_IPTV_DOWNLOAD
    $(call DOWNLOAD,$(VDR_IPTV_SITE),$(VDR_IPTV_SOURCE))
endef

define VDR_XINELIBOUTPUT_DOWNLOAD
    $(call DOWNLOAD,$(VDR_XINELIBOUTPUT_SITE),$(VDR_XINELIBOUTPUT_SOURCE))
endef

define VDR_SC_EXTRACT
    mkdir -p $(VDR_DIR)/PLUGINS/src/sc
    $(if $(VDR_SC_SOURCE),$(INFLATE$(suffix $(VDR_SC_SOURCE))) $(DL_DIR)/$(VDR_SC_SOURCE) | \
	$(TAR) $(TAR_STRIP_COMPONENTS)=1 -C $(VDR_DIR)/PLUGINS/src/sc $(TAR_OPTIONS) -)
endef
define VDR_XVDR_EXTRACT
    mkdir -p $(VDR_DIR)/PLUGINS/src/xvdr
    $(if $(VDR_XVDR_SOURCE),$(INFLATE$(suffix $(VDR_XVDR_SOURCE))) $(DL_DIR)/$(VDR_XVDR_SOURCE) | \
	$(TAR) $(TAR_STRIP_COMPONENTS)=1 -C $(VDR_DIR)/PLUGINS/src/xvdr $(TAR_OPTIONS) -)
endef
define VDR_VNSI_EXTRACT
    mkdir -p $(VDR_DIR)/PLUGINS/src/vnsiserver
    cp -r $(XBMC_DIR)/xbmc/pvrclients/vdr-vnsi/vdr-plugin-vnsiserver/* $(VDR_DIR)/PLUGINS/src/vnsiserver
endef
define VDR_IPTV_EXTRACT
    mkdir -p $(VDR_DIR)/PLUGINS/src/iptv
    $(if $(VDR_IPTV_SOURCE),$(INFLATE$(suffix $(VDR_IPTV_SOURCE))) $(DL_DIR)/$(VDR_IPTV_SOURCE) | \
	$(TAR) $(TAR_STRIP_COMPONENTS)=1 -C $(VDR_DIR)/PLUGINS/src/iptv $(TAR_OPTIONS) -)
endef
define VDR_XINELIBOUTPUT_EXTRACT
    mkdir -p $(VDR_DIR)/PLUGINS/src/xineliboutput
    $(if $(VDR_XINELIBOUTPUT_SOURCE),$(INFLATE$(suffix $(VDR_XINELIBOUTPUT_SOURCE))) $(DL_DIR)/$(VDR_XINELIBOUTPUT_SOURCE) | \
	$(TAR) $(TAR_STRIP_COMPONENTS)=1 -C $(VDR_DIR)/PLUGINS/src/xineliboutput $(TAR_OPTIONS) -)
endef

XINELIBOUTPUT_CONFIGURE_OPTS = --disable-fb \
  --disable-libextractor \
  --disable-dbus-glib-1 \
  --disable-xdpms \
  --disable-xinerama \
  --disable-xshape \
  --cc="$(TARGET_CC)" \
  --cxx="$(TARGET_CXX)" \
  --add-cflags="$(TARGET_CFLAGS)"

define VDR_XINELIBOUTPUT_POST_PATCH
    sed -i -e 's|^XINELIBOUTPUT_CONFIGURE_OPTS\ \=|XINELIBOUTPUT_CONFIGURE_OPTS=$(XINELIBOUTPUT_CONFIGURE_OPTS)|' $(VDR_DIR)/PLUGINS/src/xineliboutput/Makefile
endef

define VDR_VNSI_POST_PATCH
    sed -i -e 's|^MAKEDEP\ \=\ g++|MAKEDEP=$$(CXX)|' $(VDR_DIR)/PLUGINS/src/vnsiserver/Makefile
endef

ifeq ($(BR2_PACKAGE_VDR_SC),y)
VDR_POST_DOWNLOAD_HOOKS += VDR_SC_DOWNLOAD
VDR_POST_EXTRACT_HOOKS += VDR_SC_EXTRACT
endif
ifeq ($(BR2_PACKAGE_VDR_XVDR),y)
VDR_POST_DOWNLOAD_HOOKS += VDR_XVDR_DOWNLOAD
VDR_POST_EXTRACT_HOOKS += VDR_XVDR_EXTRACT
endif
ifeq ($(BR2_PACKAGE_VDR_VNSI),y)
VDR_DEPENDENCIES += xbmc-patch
VDR_POST_EXTRACT_HOOKS += VDR_VNSI_EXTRACT
VDR_POST_PATCH_HOOKS += VDR_VNSI_POST_PATCH
endif
ifeq ($(BR2_PACKAGE_VDR_IPTV),y)
VDR_POST_DOWNLOAD_HOOKS += VDR_IPTV_DOWNLOAD
VDR_POST_EXTRACT_HOOKS += VDR_IPTV_EXTRACT
endif
ifeq ($(BR2_PACKAGE_VDR_XINELIBOUTPUT),y)
VDR_POST_DOWNLOAD_HOOKS += VDR_XINELIBOUTPUT_DOWNLOAD
VDR_POST_EXTRACT_HOOKS += VDR_XINELIBOUTPUT_EXTRACT
VDR_POST_PATCH_HOOKS += VDR_XINELIBOUTPUT_POST_PATCH
VDR_DEPENDENCIES += xine-lib xlib_libXrender
VDR_OPKG_DEPENDENCIES += ,xine-lib,libxrender
endif
define VDR_REMOVE_SKINCURSES
    rm -rf $(VDR_DIR)/PLUGINS/src/skincurses
endef
VDR_POST_EXTRACT_HOOKS += VDR_REMOVE_SKINCURSES

define VDR_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) STRIP=$(TARGET_CROSS)strip CPUOPT=atom PARALLEL=PARALLEL_128_SSE HOST_CC="$(HOSTCC)" $(MAKE) -C $(@D) plugins
endef

define VDR_INSTALL_TARGET_CMDS
endef

define VDR_XINELIBOUTPUT_INSTALL
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) STRIP=$(TARGET_CROSS)strip $(MAKE) -C $(@D)/PLUGINS/src/xineliboutput DESTDIR="$(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)" LOCALEDIR="$(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/share/locale" install
endef

ifeq ($(BR2_PACKAGE_VDR_XINELIBOUTPUT),y)
VDR_PRE_BUILD_OPKG_HOOKS += VDR_XINELIBOUTPUT_INSTALL
endif

define VDR_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/bin
    mkdir -p $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/share/locale
    mkdir -p $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/lib/vdr/PLUGINS
    cp $(VDR_DIR)/vdr $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/bin
    cp $(VDR_DIR)/PLUGINS/lib/lib*.so.* $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/lib/vdr/PLUGINS
    cp -r $(VDR_DIR)/locale/ru_RU $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/share/locale
endef
$(eval $(call GENTARGETS,package/multimedia,vdr))
