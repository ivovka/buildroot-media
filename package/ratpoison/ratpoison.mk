#############################################################
#
# ratpoison
#
#############################################################

RATPOISON_VERSION = 1.4.5
RATPOISON_SOURCE = ratpoison-$(RATPOISON_VERSION).tar.gz
RATPOISON_SITE = http://mirror.lihnidos.org/GNU/savannah/ratpoison
RATPOISON_AUTORECONF = YES
RATPOISON_INSTALL_STAGING = NO
RATPOISON_BUILD_OPKG = YES
RATPOISON_SECTION = x11
RATPOISON_DESCRIPTION = A window manager that lets you say good-bye to the rodent
RATPOISON_DEPENDENCIES = xutil_util-macros xlib_libXft xlib_libICE xlib_libX11 xlib_libXext xlib_libXtst xlib_libXinerama xserver_xorg-server
RATPOISON_OPKG_DEPENDENCIES = libxft,libice,libx11,libxext,libxtst,libxinerama,liberation-fonts-ttf

RATPOISON_CONF_OPT = \
  --disable-debug \
  --disable-history \
  --with-xterm=rxvt \
  --with-xft \
  --with-x

define RATPOISON_OPKG_CLENUP
  rm -rf $(BUILD_DIR_OPKG)/$(RATPOISON_BASE_NAME)/usr/share
endef

RATPOISON_PRE_BUILD_OPKG_HOOKS += RATPOISON_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package,ratpoison))
