#############################################################
#
# dbus-python
#
#############################################################
DBUS_PYTHON_VERSION = 0.83.1
DBUS_PYTHON_SOURCE = dbus-python-$(DBUS_PYTHON_VERSION).tar.gz
DBUS_PYTHON_SITE = http://dbus.freedesktop.org/releases/dbus-python/
DBUS_PYTHON_AUTORECONF = YES
DBUS_PYTHON_INSTALL_STAGING = YES
DBUS_PYTHON_INSTALL_TARGET = YES
DBUS_PYTHON_BUILD_OPKG = YES
DBUS_PYTHON_SECTION = python
DBUS_PYTHON_DESCRIPTION = A message bus system. Python binding.
DBUS_PYTHON_DEPENDENCIES = dbus-glib python host-python dbus
DBUS_PYTHON_OPKG_DEPENDENCIES = python,dbus,dbus-glib

DBUS_PYTHON_CONF_OPT = --disable-html-docs --disable-api-docs

$(eval $(call AUTOTARGETS,package,dbus-python))
