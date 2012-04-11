#############################################################
#
# avahi (zeroconf implementation)
#
#############################################################
#
# This program is free software; you can redistribute it
# and/or modify it under the terms of the GNU Lesser General
# Public License as published by the Free Software Foundation
# either version 2.1 of the License, or (at your option) any
# later version.

AVAHI_VERSION = 0.6.30
AVAHI_SOURCE = avahi-$(AVAHI_VERSION).tar.gz
AVAHI_SITE = http://www.avahi.org/download/
AVAHI_AUTORECONF = YES
AVAHI_INSTALL_STAGING = YES
AVAHI_INSTALL_TARGET = YES
AVAHI_BUILD_OPKG = YES
AVAHI_DEPENDENCIES = $(if $(BR2_NEEDS_GETTEXT_IF_LOCALE),gettext libintl) host-intltool host-pkg-config dbus
AVAHI_OPKG_DEPENDENCIES = dbus
AVAHI_SECTION = network
AVAHI_DESCRIPTION = A Zeroconf mDNS/DNS-SD responder

AVAHI_CONF_ENV = \
    py_cv_mod_gtk_=yes \
    py_cv_mod_dbus_=yes \
    ac_cv_func_chroot=no \

AVAHI_CONF_OPT = \
    --with-distro=none \
    --disable-glib \
    --disable-gobject \
    --disable-qt3 \
    --disable-qt4 \
    --disable-gtk \
    --disable-gtk3 \
    --enable-dbus \
    --disable-dbm \
    --disable-gdbm \
    --disable-pygtk \
    --disable-mono \
    --disable-monodoc \
    --enable-autoipd \
    --disable-doxygen-doc \
    --disable-doxygen-dot \
    --disable-doxygen-man \
    --disable-doxygen-rtf \
    --disable-doxygen-xml \
    --disable-doxygen-chm \
    --disable-doxygen-chi \
    --disable-doxygen-html \
    --disable-doxygen-ps \
    --disable-doxygen-pdf \
    --disable-core-docs \
    --disable-manpages \
    --disable-xmltoman \
    --disable-tests \
    --disable-compat-libdns_sd \
    --disable-compat-howl \
    --with-avahi-user=avahi \
    --with-avahi-group=avahi \
    --with-autoipd-user=avahiautoipd \
    --with-autoipd-group=avahiautoipd \
    --disable-nls

ifneq ($(BR2_PACKAGE_AVAHI_DAEMON)$(BR2_PACKAGE_AVAHI_AUTOIPD),)
AVAHI_DEPENDENCIES += libdaemon
AVAHI_OPKG_DEPENDENCIES += ,libdaemon
AVAHI_CONF_OPT += --enable-libdaemon
else
AVAHI_CONF_OPT += --disable-libdaemon
endif

ifeq ($(BR2_PACKAGE_AVAHI_DAEMON),y)
AVAHI_DEPENDENCIES += expat python dbus-python
AVAHI_OPKG_DEPENDENCIES += ,expat,python,dbus-python
AVAHI_CONF_OPT += --with-xml=expat \
  --enable-python \
  --enable-python-dbus
else
AVAHI_CONF_OPT += --with-xml=none \
  --disable-python \
  --disable-python-dbus
endif

ifeq ($(BR2_PACKAGE_LIBINTL),y)
AVAHI_DEPENDENCIES += libintl
AVAHI_MAKE_OPT = LIBS=-lintl
endif

define AVAHI_REMOVE_INITSCRIPT
	rm -rf $(TARGET_DIR)/etc/init.d/avahi-*
endef

AVAHI_POST_INSTALL_TARGET_HOOKS += AVAHI_REMOVE_INITSCRIPT

define AVAHI_INSTALL_AUTOIPD
	rm -rf $(TARGET_DIR)/etc/dhcp3/
	$(INSTALL) -D -m 0755 package/avahi/busybox-udhcpc-default.script $(TARGET_DIR)/usr/share/udhcpc/default.script
	$(INSTALL) -m 0755 package/avahi/S05avahi-setup.sh $(TARGET_DIR)/etc/init.d/
	rm -f $(TARGET_DIR)/var/lib/avahi-autoipd
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/var/lib
	ln -sf /tmp/avahi-autoipd $(TARGET_DIR)/var/lib/avahi-autoipd
endef

ifeq ($(BR2_PACKAGE_AVAHI_AUTOIPD),y)
AVAHI_POST_INSTALL_TARGET_HOOKS += AVAHI_INSTALL_AUTOIPD
endif

define AVAHI_INSTALL_DAEMON_INITSCRIPT
	$(INSTALL) -m 0755 package/avahi/S50avahi-daemon $(TARGET_DIR)/etc/init.d/
endef

ifeq ($(BR2_PACKAGE_AVAHI_DAEMON),y)
AVAHI_POST_INSTALL_TARGET_HOOKS += AVAHI_INSTALL_DAEMON_INITSCRIPT
endif

define AVAHI_INST_OPKG
    mkdir -p $(BUILD_DIR_OPKG)/$(AVAHI_BASE_NAME)/etc/avahi/services
    cp $(TOPDIR)/package/avahi/config/http.service $(BUILD_DIR_OPKG)/$(AVAHI_BASE_NAME)/etc/avahi/services
    rm -rf $(BUILD_DIR_OPKG)/$(AVAHI_BASE_NAME)/usr/share/locale
endef

AVAHI_PRE_BUILD_OPKG_HOOKS += AVAHI_INST_OPKG

$(eval $(call AUTOTARGETS,package,avahi))
