#############################################################
#
# xine-lib
#
#############################################################
XINE_LIB_VERSION = 1.2.1
# Actually it is fake - i use xine version 1.1 from git
#XINE_LIB_SOURCE = xine-lib-$(XINE_LIB_VERSION).tar.xz
XINE_LIB_SOURCE = xine-lib-$(XINE_LIB_VERSION).tar.gz
XINE_LIB_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/xine/xine-lib
XINE_LIB_AUTORECONF = YES
XINE_LIB_INSTALL_STAGING = YES
XINE_LIB_INSTALL_TARGET = YES
XINE_LIB_BUILD_OPKG = YES

XINE_LIB_SECTION = multimedia
XINE_LIB_PRIORITY = optional
XINE_LIB_DESCRIPTION = A free video player

XINE_LIB_DEPENDENCIES = ffmpeg
XINE_LIB_OPKG_DEPENDENCIES = ffmpeg

# XINE_LIB_CFLAGS=$(TARGET_CFLAGS)

XINE_LIB_CONF_OPT = --disable-ipv6 \
  --disable-nls \
  --disable-aalib \
  --disable-directfb \
  --disable-fb \
  --enable-opengl \
  --enable-glu \
  --disable-vidix \
  --enable-xinerama \
  --disable-static-xv \
  --disable-xvmc \
  --enable-vdpau \
  --with-x \
  --with-alsa \
  --without-sdl \
  --disable-vcd \
  --with-external-ffmpeg \
  --disable-musepack 


$(eval $(call AUTOTARGETS,package/multimedia,xine-lib))
