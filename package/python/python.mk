#############################################################
#
# python
#
#############################################################
PYTHON_VERSION_MAJOR = 2.7
PYTHON_VERSION       = $(PYTHON_VERSION_MAJOR).2
PYTHON_SOURCE        = Python-$(PYTHON_VERSION).tar.bz2
PYTHON_SITE          = http://python.org/ftp/python/$(PYTHON_VERSION)
HOST_PYTHON_AUTORECONF = NO
PYTHON_AUTORECONF = NO
PYTHON_INSTALL_STAGING = YES
PYTHON_BUILD_OPKG = YES
HOST_PYTHON_DEPENDENCIES = host-zlib host-expat
PYTHON_DEPENDENCIES  = host-python libffi
PYTHON_OPKG_DEPENDENCIES = libffi,file
PYTHON_SECTION = lang
PYTHON_DESCRIPTION = The Python programming language

# Python needs itself and a "pgen" program to build itself, both being
# provided in the Python sources. So in order to cross-compile Python,
# we need to build a host Python first. This host Python is also
# installed in $(HOST_DIR), as it is needed when cross-compiling
# third-party Python modules.

ifeq ($(BR2_PACKAGE_PYTHON_READLINE),y)
PYTHON_DEPENDENCIES += readline
PYTHON_OPKG_DEPENDENCIES += ,readline
endif

ifeq ($(BR2_PACKAGE_PYTHON_CURSES),y)
PYTHON_DEPENDENCIES += ncurses
PYTHON_OPKG_DEPENDENCIES += ,ncurses
else
PYTHON_CONF_OPT += --disable-curses
endif

ifeq ($(BR2_PACKAGE_PYTHON_PYEXPAT),y)
PYTHON_DEPENDENCIES += expat
PYTHON_OPKG_DEPENDENCIES += ,expat
endif

ifeq ($(BR2_PACKAGE_PYTHON_BSDDB),y)
PYTHON_DEPENDENCIES += berkeleydb
PYTHON_OPKG_DEPENDENCIES += ,berkekeydb
else
PYTHON_CONF_OPT += --disable-bsddb
endif

ifeq ($(BR2_PACKAGE_PYTHON_SQLITE),y)
PYTHON_DEPENDENCIES += sqlite
PYTHON_OPKG_DEPENDENCIES += ,sqlite
else
PYTHON_CONF_OPT += --disable-sqlite3
endif

ifeq ($(BR2_PACKAGE_PYTHON_SSL),y)
PYTHON_DEPENDENCIES += openssl
PYTHON_OPKG_DEPENDENCIES += ,openssl
else
PYTHON_CONF_OPT += --disable-ssl
endif

ifneq ($(BR2_PACKAGE_PYTHON_CODECSCJK),y)
PYTHON_CONF_OPT += --disable-codecs-cjk
endif

ifeq ($(BR2_PACKAGE_PYTHON_BZIP2),y)
PYTHON_DEPENDENCIES += bzip2
PYTHON_OPKG_DEPENDENCIES += ,bzip2
else
PYTHON_CONF_OPT += --disable-bz2
endif

ifeq ($(BR2_PACKAGE_PYTHON_ZLIB),y)
PYTHON_DEPENDENCIES += zlib
PYTHON_OPKG_DEPENDENCIES += ,zlib
else
PYTHON_CONF_OPT += --disable-zlib
endif

PYTHON_DISABLED_MODULES = "readline _curses _curses_panel _tkinter nis gdbm bsddb _codecs_kr _codecs_jp _codecs_cn _codecs_tw _codecs_hk"

PYTHON_CONF_ENV += \
	ac_cv_file_dev_ptc=no \
	ac_cv_file_dev_ptmx=yes \
	ac_cv_func_lchflags_works=no \
	ac_cv_func_chflags_works=no \
	ac_cv_func_printf_zd=yes \
	OPT="$(TARGET_CFLAGS) -fno-strict-aliasing" \
	PYTHON_FOR_BUILD=$(HOST_PYTHON_DIR)/python \
	PGEN_FOR_BUILD=$(HOST_PYTHON_DIR)/Parser/pgen


#	ac_cv_have_long_long_format=yes
PYTHON_CONF_OPT += \
	--with-threads \
	--enable-unicode=ucs4	\
	--disable-ipv6 \
	--disable-profiling \
	--without-pydebug \
	--without-doc-strings \
	--without-tsc		\
	--without-pymalloc	\
	--without-fpectl	\
	--without-wctype-functions \
	--without-cxx-main 	\
	--with-system-ffi	\
	--with-system-expat

PYTHON_MAKE_ENV = \
	PYTHON_MODULES_INCLUDE="$(STAGING_DIR)/usr/include" \
	PYTHON_MODULES_LIB="$(STAGING_DIR)/lib $(STAGING_DIR)/usr/lib"

PYTHON_MAKE_OPT = \
	HOSTPYTHON=$(HOST_PYTHON_DIR)/python \
	HOSTPGEN=$(HOST_PYTHON_DIR)/Parser/pgen \
	PYTHON_DISABLE_MODULES=$(PYTHON_DISABLED_MODULES)

PYTHON_INSTALL_STAGING_OPT += $(PYTHON_MAKE_OPT)
PYTHON_INSTALL_STAGING_OPT += DESTDIR=$(STAGING_DIR) install

PYTHON_INSTALL_TARGET_OPT += $(PYTHON_MAKE_OPT)
PYTHON_INSTALL_TARGET_OPT += DESTDIR=$(TARGET_DIR) install

define PYTHON_REMOVE_AUTOCONF_CHECK
	sed -e "/version_required(2\.65)/d" -i $(PYTHON_DIR)/configure.in
endef

PYTHON_POST_PATCH_HOOKS += PYTHON_REMOVE_AUTOCONF_CHECK

define PYTHON_FIX_MAKEFILE_STAGING
  sed -e "s|^LIBDIR=.*|LIBDIR= $(STAGING_DIR)/usr/lib|" -i $(STAGING_DIR)/usr/lib/python*/config/Makefile
endef

PYTHON_POST_INSTALL_STAGING_HOOKS += PYTHON_FIX_MAKEFILE_STAGING
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

ifneq ($(BR2_HAVE_DEVFILES),y)
PYTHON_POST_INSTALL_TARGET_HOOKS += PYTHON_REMOVE_DEVFILES_TARGET
endif

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

PYTHON_POST_INSTALL_TARGET_HOOKS += PYTHON_REMOVE_USELESS_FILES_TARGET
PYTHON_POST_INSTALL_TARGET_HOOKS += PYTHON_REMOVE_USELESS_MODULES_TARGET

PYTHON_BUILD_OPKG_INC_DIRS = compiler ctypes ctypes/macholib distutils distutils/command email
PYTHON_BUILD_OPKG_INC_DIRS +=  email/mime encodings hotshot importlib json logging
PYTHON_BUILD_OPKG_INC_DIRS +=  multiprocessing sqlite3 xml xml/dom xml/etree
PYTHON_BUILD_OPKG_INC_DIRS +=  xml/parsers xml/sax

define PYTHON_BUILD_OPKG_CMDS
  mkdir -p $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/bin
  cp $(@D)/python $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/bin/
  mkdir -p $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib
  cp -PR $(@D)/libpython2.7.so.1.0 $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/
  ln -sf libpython2.7.so.1.0 $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/libpython2.7.so
  mkdir -p $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/config
  cp $(@D)/Makefile $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/config
  cp $(@D)/pyconfig.h $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/config
  mkdir -p $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/lib-dynload
  cp $(@D)/build/lib*/*.so $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/lib-dynload
  cp $(@D)/Lib/*.py $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)
  mkdir -p $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/plat-linux2
  cp $(@D)/Lib/plat-linux2/* $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/plat-linux2
  for dirs in $(PYTHON_BUILD_OPKG_INC_DIRS) ; do \
    (mkdir -p $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/$$dirs && \
    cp $(@D)/Lib/$$dirs/*.py $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/$$dirs) \
  done 
  mkdir -p $(BUILD_DIR_OPKG)/$(PYTHON_BASE_NAME)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages
endef

HOST_PYTHON_DISABLED_MODULES = "readline _curses _curses_panel _tkinter nis gdbm bsddb _codecs_kr _codecs_jp _codecs_cn _codecs_tw _codecs_hk"

HOST_PYTHON_CONF_OPT += 	\
	--without-cxx-main 	\
	--with-threads		\
	--enable-unicode=ucs4	\
	--with-system-expat

HOST_PYTHON_MAKE_ENV = \
	PYTHON_MODULES_INCLUDE=$(HOST_DIR)/usr/include \
	PYTHON_MODULES_LIB="$(HOST_DIR)/lib $(HOST_DIR)/usr/lib" \
	PYTHON_DISABLE_MODULES=$(HOST_PYTHON_DISABLED_MODULES)

define HOST_PYTHON_REMOVE_AUTOCONF_CHECK
	sed -e "/version_required(2\.65)/d" -i $(HOST_PYTHON_DIR)/configure.in
endef

HOST_PYTHON_POST_PATCH_HOOKS += HOST_PYTHON_REMOVE_AUTOCONF_CHECK

define HOST_PYTHON_LN_PYTHON2
    ln -sf python $(HOST_DIR)/usr/bin/python2
    cp $(HOST_PYTHON_DIR)/Parser/pgen $(HOST_DIR)/usr/bin/
    sed -e "s:%PREFIX%:$(STAGING_DIR)/usr:g" -e "s:%CFLAGS%:$(TARGET_CFLAGS):g" \
        $(TOPDIR)/package/python/python-config > $(HOST_DIR)/usr/bin/python2.7-config
endef

HOST_PYTHON_POST_INSTALL_HOOKS += HOST_PYTHON_LN_PYTHON2

$(eval $(call AUTOTARGETS,package,python))
$(eval $(call AUTOTARGETS,package,python,host))
