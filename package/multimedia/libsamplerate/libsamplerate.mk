################################################################################
#
# libsamplerate
#
################################################################################

LIBSAMPLERATE_VERSION = 0.1.8
LIBSAMPLERATE_SITE = http://www.mega-nerd.com/SRC
LIBSAMPLERATE_INSTALL_STAGING = YES
LIBSAMPLERATE_BUILD_OPKG = YES

LIBSAMPLERATE_SECTION = libs
LIBSAMPLERATE_DESCRIPTION = A Sample Rate Converter library for audio

LIBSAMPLERATE_DEPENDENCIES = host-pkg-config
LIBSAMPLERATE_CONF_OPT = --disable-fftw --program-transform-name=''

ifeq ($(BR2_PACKAGE_LIBSAMPLERATE_LIBSNDFILE),y)
LIBSAMPLERATE_DEPENDENCIES += libsndfile
LIBSAMPLERATE_OPKG_DEPENDENCIES = libsndfile
LIBSAMPLERATE_CONF_OPT += --enable-sndfile
else
LIBSAMPLERATE_CONF_OPT += --disable-sndfile
endif

define LIBSAMPLERATE_OPKG_RM_BIN
	rm -rf $(BUILD_DIR_OPKG)/$(LIBSAMPLERATE_BASE_NAME)/usr/bin
endef

LIBSAMPLERATE_PRE_BUILD_OPKG_HOOKS += LIBSAMPLERATE_OPKG_RM_BIN

$(eval $(call AUTOTARGETS,package/multimedia,libsamplerate))
