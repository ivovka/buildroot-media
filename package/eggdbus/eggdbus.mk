#############################################################
#
# eggdbus
#
#############################################################

EGGDBUS_VERSION = 0.6
EGGDBUS_SITE = http://hal.freedesktop.org/releases/
EGGDBUS_INSTALL_STAGING = YES
EGGDBUS_BUILD_OPKG = YES

EGGDBUS_SECTION = devel
EGGDBUS_DESCRIPTION = D-Bus bindings for GObject
EGGDBUS_OPKG_DEPENDENCIES = dbus-glib,libglib2,dbus
EGGDBUS_DEPENDENCIES = host-eggdbus dbus-glib libglib2 dbus
HOST_EGGDBUS_DEPENDENCIES = host-dbus-glib host-libglib2 host-dbus
EGGDBUS_AUTORECONF = YES

EGGDBUS_HOST_BINARY:=$(HOST_DIR)/usr/bin/eggdbus-binding-tool

EGGDBUS_CONF_OPT = \
    --localstatedir=/var \
    --disable-static \
    --enable-shared \
    --with-eggdbus-binding-tool=$(HOST_DIR)/usr/bin/eggdbus-binding-tool \
    --with-eggdbus-glib-genmarshal=$(HOST_DIR)/usr/bin/eggdbus-glib-genmarshal \
    --disable-man-pages \
    --disable-gtk-doc

HOST_EGGDBUS_CONF_OPT = \
    --disable-man-pages \
    --disable-gtk-doc

define EGGDBUS_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/lib
    cp -P $(BUILD_DIR)/$(EGGDBUS_BASE_NAME)/src/eggdbus/.libs/*.so* $(TARGET_DIR)/usr/lib
endef

define EGGDBUS_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/$(EGGDBUS_BASE_NAME)/usr/lib
    cp -P $(BUILD_DIR)/$(EGGDBUS_BASE_NAME)/src/eggdbus/.libs/*.so* $(BUILD_DIR_OPKG)/$(EGGDBUS_BASE_NAME)/usr/lib
endef

$(eval $(call AUTOTARGETS,package,eggdbus))
$(eval $(call AUTOTARGETS,package,eggdbus,host))
