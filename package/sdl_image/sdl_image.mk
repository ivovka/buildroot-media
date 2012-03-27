#############################################################
#
# SDL_image addon for SDL
#
#############################################################
SDL_IMAGE_VERSION:=1.2.10
SDL_IMAGE_SOURCE:=SDL_image-$(SDL_IMAGE_VERSION).tar.gz
SDL_IMAGE_SITE:=http://www.libsdl.org/projects/SDL_image/release
SDL_IMAGE_INSTALL_STAGING:=YES
SDL_IMAGE_INSTALL_TARGET:=YES
SDL_IMAGE_BUILD_OPKG = YES
SDL_IMAGE_NAME_OPKG = sdl-image
SDL_IMAGE_SECTION = multimedia
SDL_IMAGE_DESCRIPTION = A cross-platform Graphic API
SDL_IMAGE_OPKG_DEPENDENCIES = sdl,$(call qstrip,$(BR2_JPEG_LIBRARY)),libpng,tiff

SDL_IMAGE_CONF_OPT:=--with-sdl-prefix=$(STAGING_DIR)/usr \
		--with-sdl-exec-prefix=$(STAGING_DIR)/usr \
		--disable-sdltest \
		--disable-static \
		--enable-jpg-shared \
		--enable-png-shared \
		--enable-tif-shared \
		--enable-bmp=$(if $(BR2_PACKAGE_SDL_IMAGE_BMP),yes,no) \
		--enable-gif=$(if $(BR2_PACKAGE_SDL_IMAGE_GIF),yes,no) \
		--enable-jpg=$(if $(BR2_PACKAGE_SDL_IMAGE_JPEG),yes,no) \
		--enable-lbm=$(if $(BR2_PACKAGE_SDL_IMAGE_LBM),yes,no) \
		--enable-pcx=$(if $(BR2_PACKAGE_SDL_IMAGE_PCX),yes,no) \
		--enable-png=$(if $(BR2_PACKAGE_SDL_IMAGE_PNG),yes,no) \
		--enable-pnm=$(if $(BR2_PACKAGE_SDL_IMAGE_PNM),yes,no) \
		--enable-tga=$(if $(BR2_PACKAGE_SDL_IMAGE_TARGA),yes,no) \
		--enable-tif=$(if $(BR2_PACKAGE_SDL_IMAGE_TIFF),yes,no) \
		--enable-xcf=$(if $(BR2_PACKAGE_SDL_IMAGE_XCF),yes,no) \
		--enable-xpm=$(if $(BR2_PACKAGE_SDL_IMAGE_XPM),yes,no) \
		--enable-xv=$(if $(BR2_PACKAGE_SDL_IMAGE_XV),yes,no) \

SDL_IMAGE_DEPENDENCIES:=sdl \
	$(if $(BR2_PACKAGE_SDL_IMAGE_JPEG),$(call qstrip,$(BR2_JPEG_LIBRARY))) \
	$(if $(BR2_PACKAGE_SDL_IMAGE_PNG),libpng) \
	$(if $(BR2_PACKAGE_SDL_IMAGE_TIFF),tiff)

$(eval $(call AUTOTARGETS,package,sdl_image))
