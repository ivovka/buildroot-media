#############################################################
#
# ffmpeg
#
#############################################################

FFMPEG_VERSION = snapshot
FFMPEG_SOURCE = ffmpeg-$(FFMPEG_VERSION).tar.bz2
FFMPEG_SITE = http://ffmpeg.org/releases
FFMPEG_INSTALL_STAGING = YES
FFMPEG_BUILD_OPKG = YES
FFMPEG_SECTION = multimedia
FFMPEG_PRIORITY = optional
FFMPEG_DESCRIPTION = FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video.

FFMPEG_DEPENDENCIES = zlib libvdpau
FFMPEG_OPKG_DEPENDENCIES = zlib,libvdpau

FFMPEG_CONF_OPT = \
	--prefix=/usr		\
	--disable-avfilter	\
	--disable-doc		\
	--disable-runtime-cpudetect \
	--enable-vdpau \
	--nm="$(TARGET_NM)" \
	--ar="$(TARGET_AR)" \
	--as="$(TARGET_CC)" \
	--cc="$(TARGET_CC)" \
	--cxx="$(TARGET_CXX)" \
	--ld="$(TARGET_CC)" \
	--cpu=$(BR2_GCC_TARGET_TUNE)

ifeq ($(BR2_PACKAGE_FFMPEG_GPL),y)
FFMPEG_CONF_OPT += --enable-gpl
else
FFMPEG_CONF_OPT += --disable-gpl
endif

ifeq ($(BR2_PACKAGE_FFMPEG_NONFREE),y)
FFMPEG_CONF_OPT += --enable-nonfree
else
FFMPEG_CONF_OPT += --disable-nonfree
endif

ifeq ($(BR2_PACKAGE_FFMPEG_FFMPEG),y)
FFMPEG_CONF_OPT += --enable-ffmpeg
else
FFMPEG_CONF_OPT += --disable-ffmpeg
endif

ifeq ($(BR2_PACKAGE_FFMPEG_FFPLAY),y)
FFMPEG_DEPENDENCIES += sdl
FFMPEG_CONF_OPT += --enable-ffplay
FFMPEG_CONF_ENV += SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl-config
else
FFMPEG_CONF_OPT += --disable-ffplay
endif

ifeq ($(BR2_PACKAGE_FFMPEG_FFSERVER),y)
FFMPEG_CONF_OPT += --enable-ffserver
else
FFMPEG_CONF_OPT += --disable-ffserver
endif

ifeq ($(BR2_PACKAGE_FFMPEG_POSTPROC),y)
FFMPEG_CONF_OPT += --enable-postproc
else
FFMPEG_CONF_OPT += --disable-postproc
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SWSCALE),y)
FFMPEG_CONF_OPT += --enable-swscale
else
FFMPEG_CONF_OPT += --disable-swscale
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_ENCODERS)),all)
FFMPEG_CONF_OPT += --disable-encoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_ENCODERS)),--enable-encoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_DECODERS)),all)
FFMPEG_CONF_OPT += --disable-decoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_DECODERS)),--enable-decoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_MUXERS)),all)
FFMPEG_CONF_OPT += --disable-muxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_MUXERS)),--enable-muxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_DEMUXERS)),all)
FFMPEG_CONF_OPT += --disable-demuxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_DEMUXERS)),--enable-demuxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_PARSERS)),all)
FFMPEG_CONF_OPT += --disable-parsers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_PARSERS)),--enable-parser=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_BSFS)),all)
FFMPEG_CONF_OPT += --disable-bsfs \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_BSFS)),--enable-bsf=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_PROTOCOLS)),all)
FFMPEG_CONF_OPT += --disable-protocols \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_PROTOCOLS)),--enable-protocol=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_FILTERS)),all)
FFMPEG_CONF_OPT += --disable-filters \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_FILTERS)),--enable-filter=$(x))
endif

ifeq ($(BR2_PACKAGE_FFMPEG_INDEVS),y)
FFMPEG_CONF_OPT += --enable-indevs
else
FFMPEG_CONF_OPT += --disable-indevs
endif

ifeq ($(BR2_PACKAGE_FFMPEG_OUTDEVS),y)
FFMPEG_CONF_OPT += --enable-outdevs
else
FFMPEG_CONF_OPT += --disable-outdevs
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
FFMPEG_CONF_OPT += --enable-pthreads
else
FFMPEG_CONF_OPT += --disable-pthreads
endif

FFMPEG_CONF_OPT += --enable-zlib
# MMX on is default for x86, disable it for lowly x86-type processors
ifeq ($(BR2_x86_i386)$(BR2_x86_i486)$(BR2_x86_i586)$(BR2_x86_i686)$(BR2_x86_pentiumpro)$(BR2_x86_geode),y)
FFMPEG_CONF_OPT += --disable-mmx
endif

# ARM defaults to v5: clear if less, add extra if more
ifeq ($(BR2_generic_arm)$(BR2_arm7tdmi)$(BR2_arm610)$(BR2_arm710)$(BR2_arm720t)$(BR2_arm920t)$(BR2_arm922t),y)
FFMPEG_CONF_OPT += --disable-armv5te
endif
ifeq ($(BR2_arm1136jf_s)$(BR2_arm1176jz_s)$(BR2_arm1176jzf-s),y)
FFMPEG_CONF_OPT += --enable-armv6
endif
ifeq ($(BR2_arm10)$(BR2_arm1136jf_s)$(BR2_arm1176jz_s)$(BR2_arm1176jzf-s)$(BR2_cortex_a8)$(BR2_cortex_a9),y)
FFMPEG_CONF_OPT += --enable-armvfp
endif
# NEON is optional for A9
ifeq ($(BR2_cortex_a8),y)
FFMPEG_CONF_OPT += --enable-neon
endif
# Set powerpc altivec appropriately
ifeq ($(BR2_powerpc),y)
ifeq ($(BR2_powerpc_7400)$(BR2_powerpc_7450)$(BR2_powerpc_970),y)
FFMPEG_CONF_OPT -= --enable-altivec
else
FFMPEG_CONF_OPT += --disable-altivec
endif
endif

FFMPEG_CONF_OPT += $(call qstrip,$(BR2_PACKAGE_FFMPEG_EXTRACONF))

# Override FFMPEG_CONFIGURE_CMDS: FFmpeg does not support --target and others
define FFMPEG_CONFIGURE_CMDS
	(cd $(FFMPEG_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	$(FFMPEG_CONF_ENV) \
	./configure \
		--enable-cross-compile	\
		--cross-prefix=$(TARGET_CROSS) \
		--sysroot=$(STAGING_DIR) \
		--host-cc="$(HOSTCC)" \
		--arch=$(BR2_ARCH) \
		--target-os=linux \
		--extra-cflags=-fPIC \
		$(SHARED_STATIC_LIBS_OPTS) \
		$(FFMPEG_CONF_OPT) \
	)
endef

define FFMPEG_OPKG_RM_EXAMPLE
  rm -rf $(BUILD_DIR_OPKG)/$(FFMPEG_BASE_NAME)/usr/share/ffmpeg/examples
endef

FFMPEG_PRE_BUILD_OPKG_HOOKS += FFMPEG_OPKG_RM_EXAMPLE

$(eval $(call AUTOTARGETS,package/multimedia,ffmpeg))
