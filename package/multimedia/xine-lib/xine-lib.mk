#############################################################
#
# xine-lib
#
#############################################################
XINE_LIB_VERSION = 1.2-head
XINE_LIB_SOURCE = xine-lib-$(XINE_LIB_VERSION).tar.bz2
XINE_LIB_SITE = http://anonscm.debian.org/hg/xine-lib/xine-lib-1.2/archive
XINE_LIB_AUTORECONF = YES
XINE_LIB_INSTALL_STAGING = YES
XINE_LIB_INSTALL_TARGET = YES
XINE_LIB_BUILD_OPKG = YES

XINE_LIB_SECTION = multimedia
XINE_LIB_PRIORITY = optional
XINE_LIB_DESCRIPTION = A free video player

XINE_LIB_DEPENDENCIES = ffmpeg xlib_libXv xlib_libICE xlib_libXext mesa3d alsa-lib libvdpau libbluray libmad libmodplug libvorbis
XINE_LIB_OPKG_DEPENDENCIES = ffmpeg,libxv,libice,libxext,mesa,alsa-lib,libvdpau,libbluray,libmad,libmodplug,libvorbis

# XINE_LIB_CFLAGS=$(TARGET_CFLAGS)

XINE_LIB_CONF_OPT = --disable-ipv6 \
  --disable-nls \
  --disable-aalib \
  --disable-directfb \
  --disable-fb \
  --enable-opengl \
  --enable-glu \
  --disable-vidix \
  --disable-xinerama \
  --disable-static-xv \
  --disable-xvmc \
  --enable-vdpau \
  --with-x \
  --with-alsa \
  --without-sdl \
  --without-imagemagick \
  --disable-vcd \
  --disable-musepack \
  --disable-iconvtest \
  --disable-dxr3 \
  --disable-oss \
  --disable-gdkpixbuf \
  --without-xcb

$(eval $(call AUTOTARGETS,package/multimedia,xine-lib))
