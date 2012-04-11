################################################################################
#
# xlib_libX11 -- X.Org X11 library
#
################################################################################

XLIB_LIBX11_VERSION = 1.4.99.901
XLIB_LIBX11_SOURCE = libX11-$(XLIB_LIBX11_VERSION).tar.bz2
XLIB_LIBX11_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBX11_AUTORECONF = YES
XLIB_LIBX11_INSTALL_STAGING = YES
XLIB_LIBX11_BUILD_OPKG = YES

XLIB_LIBX11_SECTION = x11
XLIB_LIBX11_DESCRIPTION = The X11 library
XLIB_LIBX11_OPKG_DEPENDENCIES = libxau,libxcb
XLIB_LIBX11_NAME_OPKG = libx11

XLIB_LIBX11_DEPENDENCIES = libxcb xutil_util-macros xlib_xtrans xlib_libXau xproto_kbproto xproto_xproto xproto_xextproto xproto_inputproto xproto_bigreqsproto xproto_xcmiscproto host-xproto_xproto
XLIB_LIBX11_CONF_OPT = \
	--disable-secure-rpc \
	--enable-loadable-i18n \
	--enable-xthreads \
	--disable-xcms \
	--enable-xlocale \
	--enable-xkb \
	--disable-xlocaledir \
	--disable-xf86bigfont \
	--enable-malloc0returnsnull \
	--disable-specs \
	--without-xmlto \
	--without-fop \
	--enable-composecache \
	--disable-lint-library \
	--disable-ipv6 \
	--without-launchd \
	--without-lint

HOST_XLIB_LIBX11_CONF_OPT = \
	--disable-specs

HOST_XLIB_LIBX11_DEPENDENCIES = host-xproto_xextproto host-libxcb host-xutil_util-macros host-xlib_xtrans host-xlib_libXau host-xproto_kbproto host-xproto_xproto host-xproto_xextproto host-xproto_inputproto xproto_bigreqsproto host-xproto_xcmiscproto

# src/util/makekeys is executed at build time to generate ks_tables.h, so
# it should get compiled for the host. The libX11 makefile unfortunately
# doesn't know about cross compilation so this doesn't work.
# Long term, we should probably teach it about HOSTCC / HOST_CFLAGS, but for
# now simply disable the src/util Makefile and build makekeys by hand in
# advance
#define XLIB_LIBX11_DISABLE_MAKEKEYS_BUILD
#	echo '' > $(@D)/src/util/Makefile.am
#endef

#XLIB_LIBX11_POST_EXTRACT_HOOKS += XLIB_LIBX11_DISABLE_MAKEKEYS_BUILD

#define XLIB_LIBX11_BUILD_MAKEKEYS_FOR_HOST
#	cd $(@D)/src/util && $(HOSTCC) $(HOST_CFLAGS) -o makekeys makekeys.c
#endef

#XLIB_LIBX11_POST_CONFIGURE_HOOKS += XLIB_LIBX11_BUILD_MAKEKEYS_FOR_HOST

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libX11))
$(eval $(call AUTOTARGETS,package/x11r7,xlib_libX11,host))
