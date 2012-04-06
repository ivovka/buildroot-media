#############################################################
#
# MySQL 5.1 Client
#
#############################################################
MYSQL_VERSION = 5.1.62
MYSQL_SOURCE = mysql-$(MYSQL_VERSION).tar.gz
MYSQL_SITE =http://ftp.gwdg.de/pub/misc/mysql/Downloads/MySQL-5.1/
MYSQL_INSTALL_TARGET = YES
MYSQL_INSTALL_STAGING = YES
MYSQL_AUTORECONF=YES
MYSQL_BUILD_OPKG = YES
MYSQL_DEPENDENCIES = host-mysql zlib ncurses
MYSQL_OPKG_DEPENDENCIES = zlib,ncurses

MYSQL_SECTION = database
MYSQL_DESCRIPTION = A database server

MYSQL_CONF_ENV = \
  ac_cv_c_stack_direction=-1 \
  ac_cv_sys_restartable_syscalls=yes

MYSQL_CONF_OPT = \
  --with-tcp-port=3306 \
  --with-low-memory \
  --with-big-tables \
  --with-mysqld-user=mysqld \
  --with-extra-charsets=all \
  --with-pthread \
  --with-named-thread-libs=-lpthread \
  --enable-thread-safe-client \
  --enable-assembler \
  --enable-local-infile \
  --without-debug \
  --without-docs \
  --without-man \
  --with-readline \
  --without-libwrap \
  --without-pstack \
  --without-server \
  --without-embedded-server \
  --without-libedit \
  --without-query-cache \
  --without-plugin-partition \
  --without-plugin-daemon_example \
  --without-plugin-ftexample \
  --without-plugin-archive \
  --without-plugin-blackhole \
  --without-plugin-example \
  --without-plugin-federated \
  --without-plugin-ibmdb2i \
  --without-plugin-innobase \
  --without-plugin-innodb_plugin \
  --without-plugin-ndbcluster

define MYSQL_BUILD_CMDS
  $(TARGET_MAKE_ENV) $(MYSQL_MAKE) $(MYSQL_MAKE_OPT) -C $(@D)/include
  $(TARGET_MAKE_ENV) $(MYSQL_MAKE) $(MYSQL_MAKE_OPT) -C $(@D)/libmysql
  $(TARGET_MAKE_ENV) $(MYSQL_MAKE) $(MYSQL_MAKE_OPT) -C $(@D)/scripts
endef

define MYSQL_INSTALL_STAGING_CMDS
  $(TARGET_MAKE_ENV) $(MYSQL_MAKE) $(MYSQL_INSTALL_STAGING_OPT) -C $(@D)/include
  $(TARGET_MAKE_ENV) $(MYSQL_MAKE) $(MYSQL_INSTALL_STAGING_OPT) -C $(@D)/libmysql
  cp $(@D)/scripts/mysql_config $(STAGING_DIR)/usr/bin
endef

define MYSQL_LN_MYSQL_CONFIG
  sed -i "s|pkgincludedir=.*|pkgincludedir=\'$(STAGING_DIR)/usr/include/mysql\'|" $(STAGING_DIR)/usr/bin/mysql_config
  sed -i "s|pkglibdir=.*|pkglibdir=\'$(STAGING_DIR)/usr/lib/mysql\'|" $(STAGING_DIR)/usr/bin/mysql_config
  ln -sf $(STAGING_DIR)/usr/bin/mysql_config $(HOST_DIR)/usr/bin/mysql_config
endef

MYSQL_POST_INSTALL_STAGING_HOOKS += MYSQL_LN_MYSQL_CONFIG

define MYSQL_INSTALL_TARGET_CMDS
  mkdir -p $(TARGET_DIR)/usr/lib
  cp -P $(@D)/libmysql/.libs/libmysqlclient.so* $(TARGET_DIR)/usr/lib
  mkdir -p $(TARGET_DIR)/usr/share/mysql/charsets
  cp -R $(@D)/sql/share/charsets/*.xml $(TARGET_DIR)/usr/share/mysql/charsets
endef

define MYSQL_BUILD_OPKG_CMDS
  mkdir -p $(BUILD_DIR_OPKG)/$(MYSQL_BASE_NAME)/usr/lib
  cp -P $(@D)/libmysql/.libs/libmysqlclient.so* $(BUILD_DIR_OPKG)/$(MYSQL_BASE_NAME)/usr/lib
  mkdir -p $(BUILD_DIR_OPKG)/$(MYSQL_BASE_NAME)/usr/share/mysql/charsets
  cp -R $(@D)/sql/share/charsets/*.xml $(BUILD_DIR_OPKG)/$(MYSQL_BASE_NAME)/usr/share/mysql/charsets
endef

define HOST_MYSQL_BUILD_CMDS
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/include my_config.h
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/mysys libmysys.a
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/strings libmystrings.a
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/dbug factorial
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/vio libvio.a
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/dbug libdbug.a
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/regex libregex.a
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/sql gen_lex_hash
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/scripts comp_sql
  $(HOST_MAKE_ENV) $(MAKE) -C $(@D)/extra comp_err
endef

define HOST_MYSQL_INSTALL_CMDS
  cp -PR $(@D)/dbug/factorial $(HOST_DIR)/usr/bin/mysql-factorial
  cp -PR $(@D)/sql/gen_lex_hash $(HOST_DIR)/usr/bin/mysql-gen_lex_hash
  cp -PR $(@D)/scripts/comp_sql $(HOST_DIR)/usr/bin/mysql-comp_sql
  cp -PR $(@D)/extra/comp_err $(HOST_DIR)/usr/bin/mysql-comp_err
endef

$(eval $(call AUTOTARGETS,package,mysql))
$(eval $(call AUTOTARGETS,package,mysql,host))
