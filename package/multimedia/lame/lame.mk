#############################################################
#
# lame
#
#############################################################

LAME_VERSION = 3.99.4
LAME_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/lame
LAME_DEPENDENCIES = host-pkg-config
LAME_INSTALL_STAGING = YES
LAME_BUILD_OPKG = YES

LAME_SECTION = extras
LAME_PRIORITY = optional
LAME_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LAME_DESCRIPTION = LAME Aint an Mp3 Encoder

LAME_MAKE = $(MAKE1)

LAME_CONF_ENV = GTK_CONFIG=/bin/false \
ac_cv_c_stack_direction=-1 alex_cv_ieee854_float80=no

ifeq ($(BR2_PACKAGE_LAME_LIBSNDFILE),y)
LAME_DEPENDENCIES += libsndfile
LAME_OPKG_DEPENDENCIES = libsndfile
LAME_CONF_OPT += --with-fileio=sndfile
else
LAME_CONF_OPT += --with-fileio=lame
endif

LAME_CONF_OPT += \
            --disable-static \
            --enable-nasm \
            --disable-cpml \
            --disable-gtktest \
            --disable-efence \
            --disable-analyzer-hooks \
            --enable-decoder \
            --enable-decode-layer1 \
            --enable-decode-layer2 \
            --disable-frontend \
            --disable-mp3x \
            --disable-mp3rtp \
            --enable-expopt=no \
	    --disable-dynamic-frontends \
            --enable-debug=no

ifeq ($(BR2_ENDIAN),"BIG")
define LAME_BIGENDIAN_ARCH
	echo "#define WORDS_BIGENDIAN 1" >>$(@D)/config.h
endef
endif

LAME_POST_CONFIGURE_HOOKS += LAME_BIGENDIAN_ARCH

$(eval $(call AUTOTARGETS,package/multimedia,lame))
