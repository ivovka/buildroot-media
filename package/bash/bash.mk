#############################################################
#
# bash
#
#############################################################

BASH_VERSION = 4.2
BASH_SITE = $(BR2_GNU_MIRROR)/bash
BASH_DEPENDENCIES = ncurses
BASH_BUILD_OPKG = YES
BASH_SECTION = system
BASH_PRIORITY = important
BASH_DESCRIPTION = Bourne Again Shell

# Make sure we build after busybox so that /bin/sh links to bash
BASH_OPKG_DEPENDENCIES = ncurses

define BASH_APPLY_UPSTREAM_PATCHES
  for patch in `ls $(BASH_DIR_PREFIX)/$(BASH_NAME)/upstream.patches/*.patch`; do \
    cat $$patch | patch -d $(BASH_DIR) -p0; \
  done
endef

BASH_POST_EXTRACT_HOOKS += BASH_APPLY_UPSTREAM_PATCHES

BASH_CONF_ENV += bash_cv_job_control_missing=present
BASH_CONF_OPT += \
  --bindir=/bin \
  --enable-job-control \
  --without-bash-malloc \
  --without-installed-readline \
  --disable-nls \
  --disable-rpath

# Save the old sh file/link if there is one and symlink bash->sh
define BASH_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		DESTDIR=$(TARGET_DIR) exec_prefix=/ install
	rm -f $(TARGET_DIR)/bin/bashbug
	if [ -e $(TARGET_DIR)/bin/sh ]; then \
		mv -f $(TARGET_DIR)/bin/sh $(TARGET_DIR)/bin/sh.prebash; \
	fi
	ln -sf bash $(TARGET_DIR)/bin/sh
endef

# Restore the old shell file/link if there was one
define BASH_UNINSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) \
		-C $(BASH_DIR) exec_prefix=/ uninstall
	rm -f $(TARGET_DIR)/bin/sh
	if [ -e $(TARGET_DIR)/bin/sh.prebash ]; then \
		mv -f $(TARGET_DIR)/bin/sh.prebash $(TARGET_DIR)/bin/sh; \
	fi
endef

define BASH_OPKG_LN
  rm -f $(BUILD_DIR_OPKG)/$(BASH_BASE_NAME)/bin/bashbug
  ln -sf bash $(BUILD_DIR_OPKG)/$(BASH_BASE_NAME)/bin/sh
endef

BASH_PRE_BUILD_OPKG_HOOKS += BASH_OPKG_LN
$(eval $(call AUTOTARGETS,package,bash))
