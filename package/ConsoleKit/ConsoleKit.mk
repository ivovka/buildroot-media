#############################################################
#
# ConsoleKit
#
#############################################################
CONSOLEKIT_VERSION = 0.4.5
CONSOLEKIT_SOURCE = ConsoleKit-$(CONSOLEKIT_VERSION).tar.bz2
CONSOLEKIT_SITE = http://www.freedesktop.org/software/ConsoleKit/dist
CONSOLEKIT_INSTALL_STAGING = YES
CONSOLEKIT_INSTALL_TARGET = YES
CONSOLEKIT_BUILD_OPKG = YES
CONSOLEKIT_NAME_OPKG = consolekit

CONSOLEKIT_SECTION = "system"
CONSOLEKIT_DESCRIPTION = a framework for defining and tracking users, login sessions, and seats.
CONSOLEKIT_DEPENDENCIES = dbus dbus-glib polkit
CONSOLEKIT_OPKG_DEPENDENCIES = dbus,dbus-glib,polkit

CONSOLEKIT_CONF_OPT = --libexecdir=/usr/lib/ConsoleKit \
    --sysconfdir=/etc \
    --sbindir=/sbin \
    --localstatedir=/var \
    --disable-pam-module \
    --disable-docbook-docs

define CONSOLEKIT_CP_CUSTOM_SCRIPTS
    mkdir -p $(BUILD_DIR_OPKG)/$(CONSOLEKIT_BASE_NAME)/usr/lib/ConsoleKit/scripts
    cp $(TOPDIR)/package/ConsoleKit/scripts/{ck-system-restart,ck-system-stop} $(BUILD_DIR_OPKG)/$(CONSOLEKIT_BASE_NAME)/usr/lib/ConsoleKit/scripts
endef

CONSOLEKIT_PRE_BUILD_OPKG_HOOKS += CONSOLEKIT_CP_CUSTOM_SCRIPTS
$(eval $(call AUTOTARGETS,package,ConsoleKit))
