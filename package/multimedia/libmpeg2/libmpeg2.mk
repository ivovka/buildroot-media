#############################################################
#
# libmpeg2
#
#############################################################
LIBMPEG2_VERSION = 0.5.1
LIBMPEG2_SOURCE = libmpeg2-$(LIBMPEG2_VERSION).tar.gz
LIBMPEG2_SITE = http://libmpeg2.sourceforge.net/files/
LIBMPEG2_INSTALL_STAGING = YES
LIBMPEG2_BUILD_OPKG = YES

LIBMPEG2_SECTION = libs
LIBMPEG2_PRIORITY = important
LIBMPEG2_DESCRIPTION = The MPEG Library - version 2

LIBMPEG2_CONF_OPT = --without-x --disable-directx

ifeq ($(BR2_PACKAGE_LIBMPEG2_SDL),y)
LIBMPEG2_CONF_ENV += ac_cv_prog_SDLCONFIG=$(STAGING_DIR)/usr/bin/sdl-config
LIBMPEG2_CONF_OPT += --enable-sdl
LIBMPEG2_DEPENDENCIES += sdl
else
LIBMPEG2_CONF_OPT += --disable-sdl
endif

ifneq ($(BR2_PACKAGE_LIBMPEG2_BINS),y)
define LIBMPEG2_REMOVE_BINS
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,\
		mpeg2dec corrupt_mpeg2 extract_mpeg2)
endef

define LIBMPEG2_OPKG_RM_BINS
	rm -rf $(BUILD_DIR_OPKG)/$(LIBMPEG2_BASE_NAME)/usr/bin
endef

LIBMPEG2_POST_INSTALL_TARGET_HOOKS += LIBMPEG2_REMOVE_BINS

LIBMPEG2_PRE_BUILD_OPKG_HOOKS += LIBMPEG2_OPKG_RM_BINS
endif

$(eval $(call AUTOTARGETS,package/multimedia,libmpeg2))
