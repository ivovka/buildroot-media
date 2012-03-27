#############################################################
#
# SDL_mixer
#
#############################################################
SDL_MIXER_VERSION:=1.2.11
SDL_MIXER_SOURCE:=SDL_mixer-$(SDL_MIXER_VERSION).tar.gz
SDL_MIXER_SITE:=http://www.libsdl.org/projects/SDL_mixer/release/

SDL_MIXER_INSTALL_STAGING = YES
SDL_MIXER_BUILD_OPKG = YES
SDL_MIXER_NAME_OPKG = sdl-mixer
SDL_MIXER_SECTION = multimedia
SDL_MIXER_DESCRIPTION = Simple Directmedia Layer - Mixer
SDL_MIXER_OPKG_DEPENDENCIES = sdl,libmad,libogg

SDL_MIXER_DEPENDENCIES = sdl libmad libogg
SDL_MIXER_CONF_OPT = \
    --disable-music-cmd \
    --disable-music-wave \
    --disable-music-mod \
    --disable-music-midi \
    --disable-music-timidity-midi \
    --disable-music-native-midi \
    --disable-music-native-midi-gpl \
    --enable-music-ogg \
    --enable-music-ogg-shared \
    --disable-music-flac \
    --disable-music-flac-shared \
    --disable-music-mp3 \
    --enable-music-mp3-shared \
    --enable-music-mp3-mad-gpl \
    --disable-smpegtest \
    --with-sdl-prefix=$(STAGING_DIR)/usr

define SDL_MIXER_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/libSDL_mixer*.so* $(TARGET_DIR)/usr/lib/
endef

define SDL_MIXER_BUILD_OPKG_CMDS
	mkdir -p $(BUILD_DIR_OPKG)/$(SDL_MIXER_BASE_NAME)/usr/lib
	cp -dpf $(STAGING_DIR)/usr/lib/libSDL_mixer*.so* $(BUILD_DIR_OPKG)/$(SDL_MIXER_BASE_NAME)/usr/lib
endef

define SDL_MIXER_CLEAN_CMDS
	rm -f $(TARGET_DIR)/usr/lib/libSDL_mixer*.so*
	-$(MAKE) DESTDIR=$(STAGING_DIR) -C $(@D) uninstall
	-$(MAKE) -C $(@D) clean
endef

$(eval $(call AUTOTARGETS,package,sdl_mixer))
