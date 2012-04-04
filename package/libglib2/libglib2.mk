#############################################################
#
# libglib2
#
#############################################################
LIBGLIB2_VERSION_MAJOR = 2.32
LIBGLIB2_VERSION_MINOR = 0
LIBGLIB2_VERSION = $(LIBGLIB2_VERSION_MAJOR).$(LIBGLIB2_VERSION_MINOR)
LIBGLIB2_SOURCE = glib-$(LIBGLIB2_VERSION).tar.xz
LIBGLIB2_SITE = http://ftp.gnome.org/pub/gnome/sources/glib/$(LIBGLIB2_VERSION_MAJOR)

LIBGLIB2_INSTALL_STAGING = YES
LIBGLIB2_INSTALL_TARGET = YES
LIBGLIB2_BUILD_OPKG = YES

LIBGLIB2_SECTION = devel
LIBGLIB2_DESCRIPTION = C support library
LIBGLIB2_OPKG_DEPENDENCIES = zlib,pcre,libffi
LIBGLIB2_DEPENDENCIES = host-pkg-config host-libglib2 host-python zlib pcre libffi $(if $(BR2_NEEDS_GETTEXT),gettext libintl)
HOST_LIBGLIB2_DEPENDENCIES = host-pkg-config host-zlib host-libffi host-python

LIBGLIB2_INSTALL_STAGING_OPT = DESTDIR=$(STAGING_DIR) LDFLAGS=-L$(STAGING_DIR)/usr/lib install

LIBGLIB2_CONF_ENV = \
  glib_cv_long_long_format=ll \
  glib_cv_stack_grows=no \
  glib_cv_uscore=no \
  glib_cv_va_val_copy=no \
  ac_cv_func_posix_getpwuid_r=yes \
  ac_cv_func_posix_getgrgid_r=yes \
  ac_cv_func_printf_unix98=yes \
  ac_cv_func_vsnprintf_c99=yes

LIBGLIB2_CONF_OPT = \
	--disable-gtk-doc \
	--enable-debug=no \
	--disable-selinux \
	--disable-fam \
	--enable-xattr \
	--enable-regex \
	--disable-man \
	--disable-dtrace \
	--disable-systemtap \
	--disable-gcov \
	--enable-Bsymbolic \
	--with-threads=posix \
	--with-pcre=system \

HOST_LIBGLIB2_CONF_OPT = \
	--disable-gtk-doc \
	--enable-debug=no \
	--disable-man \
	--disable-rebuilds

ifneq ($(BR2_ENABLE_LOCALE),y)
LIBGLIB2_DEPENDENCIES+=libiconv
endif

ifeq ($(BR2_PACKAGE_LIBICONV),y)
LIBGLIB2_CONF_OPT += --with-libiconv=gnu
LIBGLIB2_DEPENDENCIES+=libiconv
endif

define LIBGLIB2_REMOVE_DEV_FILES
  rm -rf $(1)/usr/lib/glib-2.0
  rm -rf $(1)/usr/share/glib-2.0/gettext
  rmdir --ignore-fail-on-non-empty $(1)/usr/share/glib-2.0
  rm -f $(addprefix $(1)/usr/bin/,glib-genmarshal glib-gettextize glib-mkenums gobject-query gtester gtester-report)
endef

define LIBGLIB2_REMOVE_DEV_FILES_TARGET
  $(call LIBGLIB2_REMOVE_DEV_FILES,$(TARGET_DIR))
endef

define LIBGLIB2_REMOVE_DEV_FILES_OPKG
  $(call LIBGLIB2_REMOVE_DEV_FILES,$(BUILD_DIR_OPKG)/$(LIBGLIB2_BASE_NAME))
endef

ifneq ($(BR2_HAVE_DEVFILES),y)
LIBGLIB2_POST_INSTALL_TARGET_HOOKS += LIBGLIB2_REMOVE_DEV_FILES_TARGET
LIBGLIB2_PRE_BUILD_OPKG_HOOKS += LIBGLIB2_REMOVE_DEV_FILES_OPKG
endif

define LIBGLIB2_REMOVE_GDB_FILES
	rm -rf $(1)/usr/share/glib-2.0/gdb
	rmdir --ignore-fail-on-non-empty $(1)/usr/share/glib-2.0
endef

define LIBGLIB2_REMOVE_GDB_FILES_TARGET
  $(call LIBGLIB2_REMOVE_GDB_FILES,$(TARGET_DIR))
endef

define LIBGLIB2_REMOVE_GDB_FILES_OPKG
  $(call LIBGLIB2_REMOVE_GDB_FILES,$(BUILD_DIR_OPKG)/$(LIBGLIB2_BASE_NAME))
endef

ifneq ($(BR2_PACKAGE_GDB),y)
LIBGLIB2_POST_INSTALL_TARGET_HOOKS += LIBGLIB2_REMOVE_GDB_FILES_TARGET
LIBGLIB2_PRE_BUILD_OPKG_HOOKS += LIBGLIB2_REMOVE_GDB_FILES_OPKG
endif

define LIBGLIB2_SLIM_OPKG
  rm -rf $(BUILD_DIR_OPKG)/$(LIBGLIB2_BASE_NAME)/etc
  rm -rf $(BUILD_DIR_OPKG)/$(LIBGLIB2_BASE_NAME)/usr/bin
  rm -rf $(BUILD_DIR_OPKG)/$(LIBGLIB2_BASE_NAME)/usr/lib/gdbus-2.0
  rm -rf $(BUILD_DIR_OPKG)/$(LIBGLIB2_BASE_NAME)/usr/share
endef

LIBGLIB2_PRE_BUILD_OPKG_HOOKS += LIBGLIB2_SLIM_OPKG

$(eval $(call AUTOTARGETS,package,libglib2))
$(eval $(call AUTOTARGETS,package,libglib2,host))

LIBGLIB2_HOST_BINARY:=$(HOST_DIR)/usr/bin/glib-genmarshal
