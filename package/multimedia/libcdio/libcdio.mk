#############################################################
#
# libcdio
#
#############################################################

LIBCDIO_VERSION = 0.82
LIBCDIO_SITE = http://ftp.gnu.org/gnu/libcdio
LIBCDIO_SOURCE = libcdio-$(LIBCDIO_VERSION).tar.bz2
LIBCDIO_INSTALL_STAGING = YES
LIBCDIO_INSTALL_TARGET = YES
LIBCDIO_BUILD_OPKG = YES

LIBCDIO_SECTION = libs
LIBCDIO_PRIORITY = optional
LIBCDIO_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBCDIO_DESCRIPTION = A CD-ROM reading and control library

ifeq ($(BR2_PACKAGE_LIBICONV),y)
LIBCDIO_DEPENDENCIES += libiconv
endif

LIBCDIO_CONF_OPT = --enable-cxx \
	    --disable-cpp-progs \
	    --enable-joliet \
	    --enable-rock \
            --disable-cddb \
            --disable-vcd-info \
            --with-cd-drive \
            --with-cd-info \
            --with-cd-paranoia \
            --with-cdda_player \
            --with-cd-read \
            --with-iso-info \
            --with-iso-read \
            --without-versioned-libs \
            --with-libiconv-prefix=$(STAGING_DIR)/usr

$(eval $(call AUTOTARGETS,package/multimedia,libcdio))
