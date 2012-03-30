#############################################################
#
# libcdio
#
#############################################################

LIBCDIO_VERSION = 0.83
LIBCDIO_SITE = http://ftp.gnu.org/gnu/libcdio
LIBCDIO_SOURCE = libcdio-$(LIBCDIO_VERSION).tar.bz2
LIBCDIO_INSTALL_STAGING = YES
LIBCDIO_INSTALL_TARGET = YES
LIBCDIO_BUILD_OPKG = YES

LIBCDIO_SECTION = libs
LIBCDIO_DESCRIPTION = A CD-ROM reading and control library

ifeq ($(BR2_PACKAGE_LIBICONV),y)
LIBCDIO_DEPENDENCIES += libiconv
endif

LIBCDIO_CONF_OPT = --enable-cxx \
	    --disable-cpp-progs \
	    --enable-joliet \
	    --enable-cxx \
	    --enable-rock \
            --disable-cddb \
            --disable-vcd-info \
            --without-cd-drive \
            --without-cd-info \
            --with-cd-paranoia \
            --without-cdda_player \
            --without-cd-read \
            --without-iso-info \
            --without-iso-read \
            --without-versioned-libs \
            --with-libiconv-prefix=$(STAGING_DIR)/usr

define LIBCDIO_OPKG_RM_BIN
	rm -rf $(BUILD_DIR_OPKG)/$(LIBCDIO_BASE_NAME)/usr/bin
endef
LIBCDIO_PRE_BUILD_OPKG_HOOKS += LIBCDIO_OPKG_RM_BIN

$(eval $(call AUTOTARGETS,package/multimedia,libcdio))
