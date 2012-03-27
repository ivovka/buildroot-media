#############################################################
#
# upower
#
#############################################################

UPOWER_VERSION = 0.9.12
UPOWER_SITE = http://upower.freedesktop.org/releases
UPOWER_SOURCE = upower-$(UPOWER_VERSION).tar.xz
UPOWER_INSTALL_STAGING = NO
UPOWER_BUILD_OPKG = YES
UPOWER_DEPENDENCIES = libglib2 udev dbus dbus-glib gobject-introspection polkit
UPOWER_OPKG_DEPENDENCIES = udev,libglib2,dbus,dbus-glib,polkit,pm-utils

UPOWER_SECTION = system
UPOWER_DESCRIPTION = a modular hardware abstraction layer designed for use in Linux systems that is designed to simplify device management.

UPOWER_CONF_OPT = \
    --libexecdir=/usr/lib/upower \
    --localstatedir=/var \
    --disable-static \
    --enable-shared \
    --with-backend=linux \
    --disable-man-pages \
    --disable-gtk-doc \
    --enable-gtk-doc-html \
    --enable-gtk-doc-pdf \
    --disable-nls

$(eval $(call AUTOTARGETS,package,upower))
