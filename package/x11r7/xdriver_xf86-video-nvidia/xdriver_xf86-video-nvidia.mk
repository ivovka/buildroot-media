################################################################################
#
# xdriver_xf86-video-nvidia -- NVIDIA video driver
#
################################################################################

XDRIVER_XF86_VIDEO_NVIDIA_VERSION = 295.33
XDRIVER_XF86_VIDEO_NVIDIA_SOURCE = NVIDIA-Linux-$(ARCH)-$(XDRIVER_XF86_VIDEO_NVIDIA_VERSION)-no-compat32.run
XDRIVER_XF86_VIDEO_NVIDIA_SITE = http://us.download.nvidia.com/XFree86/Linux-$(ARCH)/$(XDRIVER_XF86_VIDEO_NVIDIA_VERSION)
XDRIVER_XF86_VIDEO_NVIDIA_AUTORECONF = NO
XDRIVER_XF86_VIDEO_NVIDIA_DEPENDENCIES = linux xserver_xorg-server xutil_util-macros xlib_libXinerama
XDRIVER_XF86_VIDEO_NVIDIA_BUILD_OPKG = YES
XDRIVER_XF86_VIDEO_NVIDIA_NAME_OPKG = xf86-video-nvidia
XDRIVER_XF86_VIDEO_NVIDIA_SECTION = x11
XDRIVER_XF86_VIDEO_NVIDIA_DESCRIPTION = The Xorg driver for NVIDIA video chips
XDRIVER_XF86_VIDEO_NVIDIA_OPKG_DEPENDENCIES = linux,libxinerama
XDRIVER_XF86_VIDEO_NVIDIA_MODVER=`ls $(TARGET_DIR)/lib/modules`

define XDRIVER_XF86_VIDEO_NVIDIA_EXTRACT_CMDS
    sh $(DL_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_SOURCE) --extract-only --target $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_NAME)
    cp -r $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_NAME)/* $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_NAME)-$(XDRIVER_XF86_VIDEO_NVIDIA_VERSION)/
    rm -rf $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_NAME)
endef

define XDRIVER_XF86_VIDEO_NVIDIA_BUILD_CMDS
    (cd $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/kernel && \
    $(TARGET_MAKE_ENV) $(MAKE) module CC="$(TARGET_CC)" LD="$(TARGET_LD)" HOST_CC="$(HOSTCC)" ARCH=$(ARCH) SYSSRC=$(BUILD_DIR)/linux-$(LINUX_VERSION) SYSOUT=$(BUILD_DIR)/linux-$(LINUX_VERSION) && \
    cd .. && \
    ln -sf libnvidia-ml.so.$(XDRIVER_XF86_VIDEO_NVIDIA_VERSION) libnvidia-ml.so.1 \
    )
endef

define XDRIVER_XF86_VIDEO_NVIDIA_INST
    mkdir -p $(1)/usr/lib/xorg/modules/drivers
    cp -P $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/nvidia_drv.so $(1)/usr/lib/xorg/modules/drivers
    mkdir -p $(1)/usr/lib/xorg/modules/extensions
    cp -P $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/libglx.so* $(1)/usr/lib/xorg/modules/extensions/libglx_nvidia.so
    mkdir -p $(1)/etc/X11
    cp $(TOPDIR)/package/x11r7/$(XDRIVER_XF86_VIDEO_NVIDIA_NAME)/config/*.conf $(1)/etc/X11
    mkdir -p $(1)/usr/lib
    cp -P $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/libnvidia-glcore.so* $(1)/usr/lib
    cp -P $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/libnvidia-ml.so* $(1)/usr/lib
    cp -P $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/tls/libnvidia-tls.so* $(1)/usr/lib
    cp -P $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/libGL.so* $(1)/usr/lib/libGL_nvidia.so.1
    mkdir -p $(1)/lib/modules/$(XDRIVER_XF86_VIDEO_NVIDIA_MODVER)/nvidia
    cp $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/kernel/nvidia.ko $(1)/lib/modules/$(XDRIVER_XF86_VIDEO_NVIDIA_MODVER)/nvidia
    mkdir -p $(1)/usr/bin
    cp $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/nvidia-smi $(1)/usr/bin
    cp $(BUILD_DIR)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME)/libvdpau_nvidia.so* $(1)/usr/lib/libvdpau_nvidia.so.1
    ln -sf libvdpau_nvidia.so.1 $(1)/usr/lib/libvdpau_nvidia.so
endef

define XDRIVER_XF86_VIDEO_NVIDIA_INSTALL_TARGET_CMDS
    $(call XDRIVER_XF86_VIDEO_NVIDIA_INST,$(TARGET_DIR))
endef
define XDRIVER_XF86_VIDEO_NVIDIA_BUILD_OPKG_CMDS
    $(call XDRIVER_XF86_VIDEO_NVIDIA_INST,$(BUILD_DIR_OPKG)/$(XDRIVER_XF86_VIDEO_NVIDIA_BASE_NAME))
endef
$(eval $(call GENTARGETS,package/x11r7,xdriver_xf86-video-nvidia))
