#############################################################
#
# SDL
#
#############################################################
SDL_VERSION:=1.2.15
SDL_SOURCE:=SDL-$(SDL_VERSION).tar.gz
SDL_SITE:=http://www.libsdl.org/release
SDL_INSTALL_STAGING = YES
SDL_BUILD_OPKG = YES
SDL_SECTION = multimedia
SDL_DESCRIPTION = A cross-platform Graphic API
SDL_DEPENDENCIES = alsa-lib host-yasm
SDL_OPKG_DEPENDENCIES = alsa-lib
SDL_CONF_ENV = ac_cv_path_DIRECTFBCONFIG=$(STAGING_DIR)/usr/bin/directfb-config

ifeq ($(BR2_PACKAGE_SDL_FBCON),y)
SDL_CONF_OPT+=--enable-video-fbcon=yes
else
SDL_CONF_OPT+=--enable-video-fbcon=no
endif

ifeq ($(BR2_PACKAGE_SDL_DIRECTFB),y)
SDL_DEPENDENCIES += directfb
SDL_CONF_OPT+=--enable-video-directfb=yes
else
SDL_CONF_OPT=--enable-video-directfb=no
endif

ifeq ($(BR2_PACKAGE_SDL_QTOPIA),y)
SDL_CONF_OPT+=--enable-video-qtopia=yes
SDL_DEPENDENCIES += qt
else
SDL_CONF_OPT+=--enable-video-qtopia=no
endif

ifeq ($(BR2_PACKAGE_SDL_X11),y)
SDL_CONF_OPT+=--enable-video-x11
SDL_DEPENDENCIES += xserver_xorg-server xlib_libX11 xlib_libXrandr mesa3d
SDL_OPKG_DEPENDENCIES += ,libx11,libxrandr,mesa
else
SDL_CONF_OPT+=--disable-video-x11
endif

ifeq ($(BR2_PACKAGE_TSLIB),y)
SDL_DEPENDENCIES += tslib
endif

SDL_CONF_OPT += \
    --enable-libc \
    --enable-audio \
    --enable-video \
    --enable-events \
    --enable-joystick \
    --enable-cdrom \
    --enable-threads \
    --enable-timers \
    --enable-file \
    --enable-loadso \
    --enable-cpuinfo \
    --enable-assembly \
    --disable-oss \
    --enable-alsa \
    --disable-alsatest \
    --enable-alsa-shared \
    --with-alsa-prefix=$(STAGING_DIR)/usr/lib \
    --with-alsa-inc-prefix=$(STAGING_DIR)/usr/include \
    --disable-esd \
    --disable-esdtest \
    --disable-esd-shared \
    --disable-pulseaudio \
    --disable-pulseaudio-shared \
    --disable-arts \
    --disable-arts-shared \
    --disable-nas \
    --disable-diskaudio \
    --disable-dummyaudio \
    --disable-mintaudio \
    --enable-nasm \
    --disable-altivec \
    --disable-ipod \
    --disable-video-nanox \
    --disable-nanox-debug \
    --disable-nanox-share-memory \
    --disable-nanox-direct-fb \
    --disable-dga \
    --disable-video-dga \
    --disable-video-photon \
    --disable-video-carbon \
    --disable-video-cocoa \
    --disable-video-ps2gs \
    --disable-video-ggi \
    --disable-video-svga \
    --disable-video-vgl \
    --disable-video-wscons \
    --disable-video-aalib \
    --disable-video-picogui \
    --disable-video-dummy \
    --enable-video-opengl \
    --disable-osmesa-shared \
    --enable-input-events \
    --disable-input-tslib \
    --disable-pth \
    --enable-pthreads \
    --enable-pthread-sem \
    --disable-stdio-redirect \
    --disable-directx \
    --enable-sdl-dlopen \
    --disable-atari-ldg \
    --disable-clock_gettime \
    --enable-x11-shared \
    --disable-video-x11-dgamouse \
    --disable-video-x11-xinerama \
    --disable-video-x11-xme \
    --enable-video-x11-xrandr \
    --disable-video-x11-vm \
    --enable-video-x11-xv \
    --with-x

# Fixup prefix= and exec_prefix= in sdl-config, and remove the
# -Wl,-rpath option.
define SDL_FIXUP_SDL_CONFIG
	$(SED) 's%prefix=/usr%prefix=$(STAGING_DIR)/usr%' \
		$(STAGING_DIR)/usr/bin/sdl-config
	$(SED) 's%exec_prefix=/usr%exec_prefix=$(STAGING_DIR)/usr%' \
		$(STAGING_DIR)/usr/bin/sdl-config
	$(SED) 's%-Wl,-rpath,\$${libdir}%%' \
		$(STAGING_DIR)/usr/bin/sdl-config
endef

SDL_POST_INSTALL_STAGING_HOOKS+=SDL_FIXUP_SDL_CONFIG

define SDL_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/libSDL*.so* $(TARGET_DIR)/usr/lib/
endef

define SDL_BUILD_OPKG_CMDS
	mkdir -p $(BUILD_DIR_OPKG)/$(SDL_BASE_NAME)/usr/lib
	cp -dpf $(STAGING_DIR)/usr/lib/libSDL*.so* $(BUILD_DIR_OPKG)/$(SDL_BASE_NAME)/usr/lib/
endef

$(eval $(call AUTOTARGETS,package,sdl))
