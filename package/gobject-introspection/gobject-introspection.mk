#############################################################
#
# gobject-introspection
#
#############################################################

GOBJECT_INTROSPECTION_VERSION = 0.10.0
GOBJECT_INTROSPECTION_SITE = http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/0.10
GOBJECT_INTROSPECTION_SOURCE = gobject-introspection-$(GOBJECT_INTROSPECTION_VERSION).tar.bz2
GOBJECT_INTROSPECTION_INSTALL_STAGING = YES
GOBJECT_INTROSPECTION_INSTALL_TARGET = NO
GOBJECT_INTROSPECTION_BUILD_OPKG = NO

define GOBJECT_INTROSPECTION_INSTALL_STAGING_CMDS
   mkdir -p $(STAGING_DIR)/usr/share/aclocal
   cp $(BUILD_DIR)/$(GOBJECT_INTROSPECTION_BASE_NAME)/m4/introspection.m4 $(STAGING_DIR)/usr/share/aclocal
endef
$(eval $(call GENTARGETS,package,gobject-introspection))
