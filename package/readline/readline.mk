#############################################################
#
# build GNU readline
#
#############################################################

READLINE_VERSION = 6.2
READLINE_SOURCE = readline-$(READLINE_VERSION).tar.gz
READLINE_SITE = $(BR2_GNU_MIRROR)/readline
READLINE_INSTALL_STAGING = YES
READLINE_INSTALL_TARGET = YES
READLINE_BUILD_OPKG = YES

READLINE_SECTION = devel
READLINE_PRIORITY = optional
READLINE_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
READLINE_DESCRIPTION = GNU readline
READLINE_OPKG_DEPENDENCIES = ncurses

READLINE_DEPENDENCIES = ncurses

READLINE_CONF_ENV = bash_cv_func_sigsetjmp=yes

define READLINE_INSTALL_TARGET_CMDS
	$(MAKE1) DESTDIR=$(TARGET_DIR) -C $(@D) uninstall
	$(MAKE1) DESTDIR=$(TARGET_DIR) -C $(@D) install-shared uninstall-doc
	chmod 775 $(TARGET_DIR)/usr/lib/libreadline.so.$(READLINE_VERSION) \
		$(TARGET_DIR)/usr/lib/libhistory.so.$(READLINE_VERSION)
	$(STRIPCMD) $(STRIP_STRIP_UNNEEDED) \
		$(TARGET_DIR)/usr/lib/libreadline.so.$(READLINE_VERSION) \
		$(TARGET_DIR)/usr/lib/libhistory.so.$(READLINE_VERSION)
endef

define READLINE_BUILD_OPKG_CMDS
	$(MAKE1) DESTDIR=$(BUILD_DIR_OPKG)/readline-$(READLINE_VERSION) -C $(@D) uninstall
	$(MAKE1) DESTDIR=$(BUILD_DIR_OPKG)/readline-$(READLINE_VERSION) -C $(@D) install-shared uninstall-doc
	chmod 775 $(BUILD_DIR_OPKG)/readline-$(READLINE_VERSION)/usr/lib/libreadline.so.$(READLINE_VERSION) \
		$(BUILD_DIR_OPKG)/readline-$(READLINE_VERSION)/usr/lib/libhistory.so.$(READLINE_VERSION)
	$(STRIPCMD) $(STRIP_STRIP_UNNEEDED) \
		$(BUILD_DIR_OPKG)/readline-$(READLINE_VERSION)/usr/lib/libreadline.so.$(READLINE_VERSION) \
		$(BUILD_DIR_OPKG)/readline-$(READLINE_VERSION)/usr/lib/libhistory.so.$(READLINE_VERSION)
endef

$(eval $(call AUTOTARGETS,package,readline))
