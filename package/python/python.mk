#############################################################
#
# python
#
#############################################################
PYTHON_VERSION_MAJOR = 2.7
PYTHON_VERSION       = $(PYTHON_VERSION_MAJOR).1
PYTHON_SOURCE        = Python-$(PYTHON_VERSION).tar.bz2
PYTHON_SITE          = http://python.org/ftp/python/$(PYTHON_VERSION)
PYTHON_BUILD_OPKG = YES

PYTHON_SECTION = lang
PYTHON_PRIORITY = optional
PYTHON_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
PYTHON_DESCRIPTION = The Python programming language
PYTHON_OPKG_DEPENDENCIES = libffi,file

# Python needs itself and a "pgen" program to build itself, both being
# provided in the Python sources. So in order to cross-compile Python,
# we need to build a host Python first. This host Python is also
# installed in $(HOST_DIR), as it is needed when cross-compiling
# third-party Python modules.

HOST_PYTHON_CONF_OPT += 	\
	--without-cxx-main 	\
	--disable-sqlite3	\
	--disable-tk		\
	--with-expat=system	\
	--disable-curses	\
	--disable-codecs-cjk	\
	--disable-nis		\
	--disable-unicodedata	\
	--disable-dbm		\
	--disable-gdbm		\
	--disable-bsddb		\
	--disable-test-modules	\
	--disable-bz2		\
	--disable-ssl

HOST_PYTHON_MAKE_ENV = \
	PYTHON_MODULES_INCLUDE=$(HOST_DIR)/usr/include \
	PYTHON_MODULES_LIB="$(HOST_DIR)/lib $(HOST_DIR)/usr/lib"

HOST_PYTHON_AUTORECONF = YES

PYTHON_DEPENDENCIES  = zlib host-python libffi

HOST_PYTHON_DEPENDENCIES = host-expat

PYTHON_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_PYTHON_READLINE),y)
PYTHON_DEPENDENCIES += readline
endif

ifeq ($(BR2_PACKAGE_PYTHON_CURSES),y)
PYTHON_DEPENDENCIES += ncurses
else
PYTHON_CONF_OPT += --disable-curses
endif

ifeq ($(BR2_PACKAGE_PYTHON_PYEXPAT),y)
PYTHON_DEPENDENCIES += expat
PYTHON_CONF_OPT += --with-expat=system
else
PYTHON_CONF_OPT += --with-expat=none
endif

ifeq ($(BR2_PACKAGE_PYTHON_BSDDB),y)
PYTHON_DEPENDENCIES += berkeleydb
else
PYTHON_CONF_OPT += --disable-bsddb
endif

ifeq ($(BR2_PACKAGE_PYTHON_SQLITE),y)
PYTHON_DEPENDENCIES += sqlite
else
PYTHON_CONF_OPT += --disable-sqlite3
endif

ifeq ($(BR2_PACKAGE_PYTHON_SSL),y)
PYTHON_DEPENDENCIES += openssl
else
PYTHON_CONF_OPT += --disable-ssl
endif

ifneq ($(BR2_PACKAGE_PYTHON_CODECSCJK),y)
PYTHON_CONF_OPT += --disable-codecs-cjk
endif

ifneq ($(BR2_PACKAGE_PYTHON_UNICODEDATA),y)
PYTHON_CONF_OPT += --disable-unicodedata
endif

ifeq ($(BR2_PACKAGE_PYTHON_BZIP2),y)
PYTHON_DEPENDENCIES += bzip2
else
PYTHON_CONF_OPT += --disable-bz2
endif

ifeq ($(BR2_PACKAGE_PYTHON_ZLIB),y)
PYTHON_DEPENDENCIES += zlib
else
PYTHON_CONF_OPT += --disable-zlib
endif

PYTHON_CONF_ENV += \
	PYTHON_FOR_BUILD=$(HOST_PYTHON_DIR)/python \
	PGEN_FOR_BUILD=$(HOST_PYTHON_DIR)/Parser/pgen \
	ac_cv_have_long_long_format=yes

PYTHON_CONF_OPT += \
	--without-cxx-main 	\
	--without-doc-strings	\
	--with-system-ffi	\
	--disable-pydoc		\
	--disable-test-modules	\
	--disable-lib2to3	\
	--disable-gdbm		\
	--disable-tk		\
	--disable-nis		\
	--disable-dbm		\
	--with-threads		\
	--enable-unicode=ucs4	\
	--without-tsc		\
	--without-pymalloc	\
	--without-fpectl	\
	--without-wctype-functions \
	--without-pydebug \
	--without-doc-strings

PYTHON_MAKE_ENV = \
	PYTHON_MODULES_INCLUDE=$(STAGING_DIR)/usr/include \
	PYTHON_MODULES_LIB="$(STAGING_DIR)/lib $(STAGING_DIR)/usr/lib"

define PYTHON_REMOVE_AUTOCONF_CHECK
	sed -e "/version_required(2\.65)/d" -i $(PYTHON_DIR)/configure.in
endef

PYTHON_POST_PATCH_HOOKS += PYTHON_REMOVE_AUTOCONF_CHECK
define HOST_PYTHON_REMOVE_AUTOCONF_CHECK
	sed -e "/version_required(2\.65)/d" -i $(HOST_PYTHON_DIR)/configure.in
endef

HOST_PYTHON_POST_PATCH_HOOKS += HOST_PYTHON_REMOVE_AUTOCONF_CHECK
#
# Development files removal
#
define PYTHON_REMOVE_DEVFILES
	rm -f $(1)/usr/bin/python$(PYTHON_VERSION_MAJOR)-config
	rm -f $(1)/usr/bin/python-config
endef

define PYTHON_REMOVE_DEVFILES_TARGET
  $(call PYTHON_REMOVE_DEVFILES,$(TARGET_DIR))
endef

define PYTHON_REMOVE_DEVFILES_OPKG
  $(call PYTHON_REMOVE_DEVFILES,$(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME))
endef

ifneq ($(BR2_HAVE_DEVFILES),y)
PYTHON_POST_INSTALL_TARGET_HOOKS += PYTHON_REMOVE_DEVFILES_TARGET
endif

PYTHON_PRE_BUILD_OPKG_HOOKS += PYTHON_REMOVE_DEVFILES_OPKG

#
# Remove useless files. In the config/ directory, only the Makefile
# and the pyconfig.h files are needed at runtime.
#
define PYTHON_REMOVE_USELESS_FILES
	for i in `find $(1)/usr/lib/python$(PYTHON_VERSION_MAJOR)/config/ \
		-type f -not -name pyconfig.h -a -not -name Makefile` ; do \
		rm -f $$i ; \
	done
endef

define PYTHON_REMOVE_USELESS_FILES_TARGET
  $(call PYTHON_REMOVE_USELESS_FILES,$(TARGET_DIR))
endef

define PYTHON_REMOVE_USELESS_FILES_OPKG
  $(call PYTHON_REMOVE_USELESS_FILES,$(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME))
endef

define PYTHON_REMOVE_USELESS_MODULES
	rm -f $(1)/usr/bin/smtpd.py
	for i in `find $(1)/usr/lib/python$(PYTHON_VERSION_MAJOR)/distutils/command -type f -name *.exe` ; do \
		rm -f $$i ; \
	done
	rm -rf $(1)/usr/lib/python$(PYTHON_VERSION_MAJOR)/idlelib
	rm -rf $(1)/usr/lib/python$(PYTHON_VERSION_MAJOR)/multiprocessing/dummy
	rm -rf $(1)/usr/lib/python$(PYTHON_VERSION_MAJOR)/unittest
	rm -rf $(1)/usr/lib/python$(PYTHON_VERSION_MAJOR)/wsgiref
endef

define PYTHON_REMOVE_USELESS_MODULES_TARGET
  $(call PYTHON_REMOVE_USELESS_MODULES,$(TARGET_DIR))
endef

define PYTHON_REMOVE_USELESS_MODULES_OPKG
  $(call PYTHON_REMOVE_USELESS_MODULES,$(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME))
endef

PYTHON_POST_INSTALL_TARGET_HOOKS += PYTHON_REMOVE_USELESS_FILES_TARGET
PYTHON_POST_INSTALL_TARGET_HOOKS += PYTHON_REMOVE_USELESS_MODULES_TARGET
PYTHON_PRE_BUILD_OPKG_HOOKS += PYTHON_REMOVE_USELESS_FILES_OPKG
PYTHON_PRE_BUILD_OPKG_HOOKS += PYTHON_REMOVE_USELESS_MODULES_OPKG

define HOST_PYTHON_LN_PYTHON2
    ln -sf python $(HOST_DIR)/usr/bin/python2
endef

HOST_PYTHON_POST_INSTALL_HOOKS += HOST_PYTHON_LN_PYTHON2

PYTHON_AUTORECONF = YES

$(eval $(call AUTOTARGETS,package,python))
$(eval $(call AUTOTARGETS,package,python,host))
