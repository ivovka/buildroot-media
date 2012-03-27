################################################################################
#
# xserver_xorg-server -- No description available
#
################################################################################

XSERVER_XORG_SERVER_VERSION = 1.12.0
XSERVER_XORG_SERVER_SOURCE = xorg-server-$(XSERVER_XORG_SERVER_VERSION).tar.bz2
XSERVER_XORG_SERVER_SITE = ftp://ftp.x.org/pub/individual/xserver
XSERVER_XORG_SERVER_MAKE = $(MAKE1) # make install fails with parallel make
XSERVER_XORG_SERVER_AUTORECONF = YES
XSERVER_XORG_SERVER_INSTALL_STAGING = YES
XSERVER_XORG_SERVER_BUILD_OPKG = YES
XSERVER_XORG_SERVER_NAME_OPKG = xorg-server
XSERVER_XORG_SERVER_SECTION = x11
XSERVER_XORG_SERVER_DESCRIPTION = The Xorg X server
XSERVER_XORG_SERVER_OPKG_DEPENDENCIES = libpciaccess,freetype,libx11,libxfont,libxkbfile,libdrm,mesa,pixman,udev,libxinerama,font-xfree86-type1,encodings,font-bitstream-type1,font-misc-misc,xkbcomp,xkeyboard-config,xf86-input-evdev,pciutils,xrandr,setxkbmap,xf86-video-nvidia

XSERVER_XORG_SERVER_INSTALL_STAGING_OPT = DESTDIR=$(STAGING_DIR) install install-data

XSERVER_XORG_SERVER_DEPENDENCIES = 	\
	xutil_util-macros 		\
	xfont_font-util			\
	xproto_fontsproto 		\
	xproto_randrproto 		\
	xproto_recordproto		\
	xproto_renderproto 		\
	xproto_scrnsaverproto		\
	xproto_videoproto 		\
	xproto_inputproto 		\
	xproto_xf86dgaproto 		\
	xproto_xf86miscproto 		\
	xproto_xf86driproto		\
	xproto_glproto 			\
	xlib_libX11 			\
	xlib_libXfont 			\
	xlib_libxkbfile 		\
	xlib_libXinerama 		\
	mesa3d				\
	openssl 			\
	freetype			\
	pixman 				\
	udev

XSERVER_XORG_SERVER_CONF_OPT = \
    --disable-debug \
    --disable-silent-rules \
    --disable-strict-compilation \
    --enable-largefile \
    --enable-visibility \
    --enable-pc98=auto \
    --enable-install-libxf86config \
    --disable-xselinux \
    --with-pic \
    --enable-glx-tls \
    --enable-registry \
    --enable-xinerama \
    --enable-mitshm \
    --disable-xres \
    --enable-record \
    --enable-xv \
    --enable-dga \
    --disable-xdmcp \
    --disable-xdm-auth-1 \
    --enable-glx \
    --enable-dri \
    --enable-dri2 \
    --enable-xf86vidmode \
    --enable-xace \
    --disable-xcsecurity \
    --disable-xcalibrate \
    --disable-tslib \
    --enable-dbe \
    --disable-xf86bigfont \
    --enable-dpms \
    --enable-config-udev \
    --disable-config-dbus \
    --disable-config-hal \
    --enable-xfree86-utils \
    --disable-windowswm \
    --disable-xvfb \
    --disable-xnest \
    --disable-xquartz \
    --disable-standalone-xpbproxy \
    --disable-xwin \
    --disable-xephyr \
    --disable-xfake \
    --disable-install-setuid \
    --disable-secure-rpc \
    --disable-docs \
    --disable-devel-docs \
    --with-int10=x86emu \
    --disable-ipv6 \
    --with-sha1=libcrypto \
    --with-os-vendor="HTPCOS" \
    --with-builder-addr=vladimir_iva@pisem.net \
    --with-module-dir="/usr/lib/xorg/modules" \
    --with-xkb-path="/usr/share/X11/xkb" \
    --with-xkb-output=/var/cache/xkb \
    --with-log-dir=/var/log \
    --with-fontrootdir=/usr/share/fonts \
    --with-default-font-path="/usr/share/fonts/misc,built-ins"

#CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include/pixman-1"

ifeq ($(BR2_PACKAGE_XSERVER_xorg),y)
XSERVER_XORG_SERVER_CONF_OPT += --enable-xorg
XSERVER_XORG_SERVER_DEPENDENCIES += xlib_libpciaccess libdrm
else
XSERVER_XORG_SERVER_CONF_OPT += --disable-xorg
endif

ifeq ($(BR2_PACKAGE_XSERVER_tinyx),y)
XSERVER_XORG_SERVER_CONF_OPT += --enable-kdrive --enable-xfbdev \
		--disable-glx --disable-dri --disable-xsdl
define XSERVER_CREATE_X_SYMLINK
 ln -f -s Xfbdev $(TARGET_DIR)/usr/bin/X
endef
XSERVER_XORG_SERVER_POST_INSTALL_TARGET_HOOKS += XSERVER_CREATE_X_SYMLINK
else
XSERVER_XORG_SERVER_CONF_OPT += --disable-kdrive --enable-xfbdev
endif

ifeq ($(BR2_PACKAGE_XSERVER_XORG_SERVER_NULL_CURSOR),y)
XSERVER_XORG_SERVER_CONF_OPT += --enable-null-root-cursor
else
XSERVER_XORG_SERVER_CONF_OPT += --disable-null-root-cursor
endif

ifeq ($(BR2_PACKAGE_XSERVER_XORG_SERVER_AIGLX),y)
XSERVER_XORG_SERVER_CONF_OPT += --enable-aiglx
else
XSERVER_XORG_SERVER_CONF_OPT += --disable-aiglx
endif

# Optional packages
ifneq ($(BR2_PACKAGE_XLIB_LIBXVMC),y)
XSERVER_XORG_SERVER_CONF_OPT += --disable-xvmc
endif

ifneq ($(BR2_PACKAGE_XLIB_LIBXCOMPOSITE),y)
XSERVER_XORG_SERVER_CONF_OPT += --disable-composite
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXSCRNSAVER),y)
XSERVER_XORG_SERVER_DEPENDENCIES += xlib_libXScrnSaver
XSERVER_XORG_SERVER_CONF_OPT += --enable-screensaver
else
XSERVER_XORG_SERVER_CONF_OPT += --disable-screensaver
endif

ifneq ($(BR2_PACKAGE_XLIB_LIBDMX),y)
XSERVER_XORG_SERVER_CONF_OPT += --disable-dmx
endif

define XSERVER_XORG_SERVER_RM_SDKSYMS
    rm -rf $(@D)/hw/xfree86/loader/sdksyms.c
endef

define XSERVER_XORG_SERVER_CP_SCRIPTS
    mkdir -p $(BUILD_DIR_OPKG)/xserver_xorg-server-$(XSERVER_XORG_SERVER_VERSION)/lib/udev
    cp $(TOPDIR)/package/x11r7/xserver_xorg-server/scripts/xorg_start $(BUILD_DIR_OPKG)/xserver_xorg-server-$(XSERVER_XORG_SERVER_VERSION)/lib/udev
endef

XSERVER_XORG_SERVER_POST_PATCH_HOOKS += XSERVER_XORG_SERVER_RM_SDKSYMS
XSERVER_XORG_SERVER_PRE_BUILD_OPKG_HOOKS += XSERVER_XORG_SERVER_CP_SCRIPTS

$(eval $(call AUTOTARGETS,package/x11r7,xserver_xorg-server))
