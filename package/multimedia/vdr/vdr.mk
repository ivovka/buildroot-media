#############################################################
#
# vdr
#
#############################################################
VDR_VERSION = 1.7.21
VDR_SITE = ftp://ftp.tvdr.de/vdr/Developer
VDR_SOURCE = vdr-$(VDR_VERSION).tar.bz2

VDR_SC_SITE = http://85.17.209.13:6100
VDR_SC_VERSION = 442eee2f550d
VDR_SC_SOURCE = sc-$(VDR_SC_VERSION).tar.bz2

VDR_XVDR_SITE = https://nodeload.github.com
#VDR_XVDR_VERSION = 0.9.5-11-g05a82c5
VDR_XVDR_VERSION = 0.9.5-27-gc98852f
VDR_XVDR_SOURCE = pipelka-vdr-plugin-xvdr-$(VDR_XVDR_VERSION).tar.gz

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
ifeq ($(BR2_PACKAGE_VDR_SC),y)
VDR_POST_DOWNLOAD_HOOKS += VDR_SC_DOWNLOAD
VDR_POST_EXTRACT_HOOKS += VDR_SC_EXTRACT
endif
ifeq ($(BR2_PACKAGE_VDR_XVDR),y)
VDR_POST_DOWNLOAD_HOOKS += VDR_XVDR_DOWNLOAD
VDR_POST_EXTRACT_HOOKS += VDR_XVDR_EXTRACT
endif
define VDR_REMOVE_SKINCURSES
    rm -rf $(VDR_DIR)/PLUGINS/src/skincurses
endef
VDR_POST_EXTRACT_HOOKS += VDR_REMOVE_SKINCURSES

define VDR_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) CPUOPT=atom PARALLEL=PARALLEL_128_SSE $(MAKE) -C $(@D) plugins
endef

define VDR_INSTALL_TARGET_CMDS
endef

define VDR_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/bin
    mkdir -p $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/share/locale
    mkdir -p $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/etc/vdr
    mkdir -p $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/lib/vdr/PLUGINS
    cp $(VDR_DIR)/{svdrpsend.pl,vdr} $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/bin
    cp $(VDR_DIR)/*.conf $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/etc/vdr
    cp $(VDR_DIR)/PLUGINS/lib/lib*-*.so.$(VDR_VERSION) $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/lib/vdr/PLUGINS
    cp -r $(VDR_DIR)/locale/ru_RU $(BUILD_DIR_OPKG)/vdr-$(VDR_VERSION)/usr/share/locale
endef
$(eval $(call GENTARGETS,package/multimedia,vdr))
