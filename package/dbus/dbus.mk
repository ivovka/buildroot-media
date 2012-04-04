#############################################################
#
# dbus
#
#############################################################
DBUS_VERSION = 1.4.20
DBUS_SOURCE = dbus-$(DBUS_VERSION).tar.gz
DBUS_SITE = http://dbus.freedesktop.org/releases/dbus/
DBUS_INSTALL_STAGING = YES
DBUS_INSTALL_TARGET = YES
DBUS_BUILD_OPKG = YES
DBUS_SECTION = system
DBUS_PRIORITY = required
DBUS_DESCRIPTION = simple interprocess messaging system
DBUS_OPKG_DEPENDENCIES = expat

DBUS_DEPENDENCIES = host-pkg-config expat

DBUS_CONF_ENV = ac_cv_have_abstract_sockets=yes
DBUS_CONF_OPT = \
    --disable-static \
    --localstatedir=/var \
    --libexecdir=/usr/lib/dbus \
    --disable-tests \
    --disable-ansi \
    --disable-verbose-mode \
    --disable-asserts \
    --disable-checks \
    --disable-xml-docs \
    --disable-doxygen-docs \
    --enable-abstract-sockets \
    --disable-x11-autolaunch \
    --disable-selinux \
    --disable-libaudit \
    --enable-dnotify \
    --enable-inotify \
    --without-x \
    --with-dbus-user=dbus \
    --program-prefix="" \
    --with-system-socket=/var/run/dbus/system_bus_socket \
    --with-system-pid-file=/var/run/messagebus.pid

ifeq ($(BR2_DBUS_EXPAT),y)
DBUS_CONF_OPT += --with-xml=expat
DBUS_DEPENDENCIES += expat
DBUS_OPKG_DEPENDENCIES += ,expat
else
DBUS_CONF_OPT += --with-xml=libxml
DBUS_DEPENDENCIES += libxml2
DBUS_OPKG_DEPENDENCIES += ,libxml2
endif

define DBUS_CP_OPKG_SCRIPTS
    mkdir -p $(BUILD_DIR_OPKG)/$(DBUS_BASE_NAME)/CONTROL
    cp $(TOPDIR)/package/dbus/opkg-postinst $(BUILD_DIR_OPKG)/$(DBUS_BASE_NAME)/CONTROL/postinst
endef

define DBUS_OPKG_RM_INCLUDE
    rm -rf $(BUILD_DIR_OPKG)/$(DBUS_BASE_NAME)/usr/lib/dbus-1.0
    rm -rf $(BUILD_DIR_OPKG)/$(DBUS_BASE_NAME)/var
endef

DBUS_PRE_BUILD_OPKG_HOOKS += DBUS_CP_OPKG_SCRIPTS
DBUS_PRE_BUILD_OPKG_HOOKS += DBUS_OPKG_RM_INCLUDE

# fix rebuild (dbus makefile errors out if /var/lib/dbus is a symlink)
define DBUS_REMOVE_VAR_LIB_DBUS
	rm -rf $(TARGET_DIR)/var/lib/dbus
endef

DBUS_POST_BUILD_HOOKS += DBUS_REMOVE_VAR_LIB_DBUS

define DBUS_REMOVE_DEVFILES
	rm -rf $(TARGET_DIR)/usr/lib/dbus-1.0
endef

ifneq ($(BR2_HAVE_DEVFILES),y)
DBUS_POST_INSTALL_TARGET_HOOKS += DBUS_REMOVE_DEVFILES
endif

define DBUS_INSTALL_TARGET_FIXUP
	rm -rf $(TARGET_DIR)/var/lib/dbus
	ln -sf /tmp/dbus $(TARGET_DIR)/var/lib/dbus
endef

DBUS_POST_INSTALL_TARGET_HOOKS += DBUS_INSTALL_TARGET_FIXUP

HOST_DBUS_DEPENDENCIES = host-pkg-config host-expat
HOST_DBUS_CONF_OPT = \
		--with-dbus-user=dbus \
		--disable-tests \
		--disable-asserts \
		--enable-abstract-sockets \
		--disable-selinux \
		--disable-xml-docs \
		--disable-doxygen-docs \
		--disable-static \
		--enable-dnotify \
		--without-x \
		--with-xml=expat

# dbus for the host
DBUS_HOST_INTROSPECT=$(HOST_DBUS_DIR)/introspect.xml

HOST_DBUS_GEN_INTROSPECT = \
	$(HOST_DIR)/usr/bin/dbus-daemon --introspect > $(DBUS_HOST_INTROSPECT)

HOST_DBUS_POST_INSTALL_HOOKS += HOST_DBUS_GEN_INTROSPECT

$(eval $(call AUTOTARGETS,package,dbus))
$(eval $(call AUTOTARGETS,package,dbus,host))
