#############################################################
#
# ncurses
# this installs only a few vital termcap entries
#
#############################################################
# Copyright (C) 2002 by Ken Restivo <ken@246gt.com>
# $Id: ncurses.mk,v 1.7 2005/01/03 04:38:13 andersen Exp $
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Library General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Library General Public License for more details.
#
# You should have received a copy of the GNU Library General Public
# License along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA

# TARGETS
NCURSES_VERSION = 5.7
NCURSES_SITE = $(BR2_GNU_MIRROR)/ncurses
NCURSES_INSTALL_STAGING = YES
NCURSES_BUILD_OPKG = YES

NCURSES_SECTION = devel
NCURSES_DESCRIPTION = The ncurses (new curses) library

NCURSES_CONF_OPT = \
	--with-shared \
	--without-cxx \
	--without-cxx-binding \
	--without-ada \
	--without-progs \
	--without-tests \
	--disable-big-core \
	--without-profile \
	--disable-rpath \
	--enable-echo \
	--enable-const \
	--enable-overwrite \
	--enable-broken_linker \
	--with-termlib \
	--enable-termcap \
	--enable-getcap \
	--disable-getcap-cache \
	--disable-tcap-names \
	--disable-static

ifneq ($(BR2_ENABLE_DEBUG),y)
NCURSES_CONF_OPT += --without-debug
endif


define NCURSES_BUILD_CMDS
	$(MAKE1) -C $(@D) DESTDIR=$(STAGING_DIR)
endef

define NCURSES_PATCH_NCURSES_CONFIG
	$(SED) 's^prefix="^prefix="$(STAGING_DIR)^' \
		$(STAGING_DIR)/usr/bin/ncurses5-config
endef

NCURSES_POST_INSTALL_STAGING_HOOKS += NCURSES_PATCH_NCURSES_CONFIG

#
# 1) Target directory
#
define NCURSES_INSTALL_DEVFILES
    mkdir -p $(1)/usr/include
    cp -dpf $(NCURSES_DIR)/include/curses.h $(1)/usr/include/curses.h
    cp -dpf $(NCURSES_DIR)/include/ncurses_dll.h $(1)/usr/include/ncurses_dll.h
    cp -dpf $(NCURSES_DIR)/include/term.h $(1)/usr/include/
    cp -dpf $(NCURSES_DIR)/include/unctrl.h $(1)/usr/include/
    cp -dpf $(NCURSES_DIR)/include/termcap.h $(1)/usr/include/
    cp -dpf $(NCURSES_DIR)/lib/libncurses.a $(1)/usr/lib/
    (cd $(1)/usr/lib; \
     ln -fs libncurses.a libcurses.a; \
     ln -fs libncurses.a libtermcap.a; \
    )
    (cd $(1)/usr/include; ln -fs curses.h ncurses.h)
    rm -f $(1)/usr/lib/libncurses.so
    (cd $(1)/usr/lib; ln -fs libncurses.so.$(NCURSES_VERSION) libncurses.so)
endef

define NCURSES_INSTALL_ONE_FILE
    cp -dpf $(NCURSES_DIR)/lib/$(1).so* $(2)/usr/lib/
endef

ifeq ($(BR2_HAVE_DEVFILES),y)
define NCURSES_INSTALL_TARGET_DEVFILES
    $(call NCURSES_INSTALL_DEVFILES,$(TARGET_DIR))
endef
define NCURSES_INSTALL_OPKG_DEVFILES
    $(call NCURSES_INSTALL_DEVFILES,$(BUILD_DIR_OPKG)/ncurses-$(NCURSES_VERSION))
endef
endif

ifeq ($(BR2_PACKAGE_NCURSES_TARGET_PANEL),y)
define NCURSES_INSTALL_TARGET_PANEL
    $(call NCURSES_INSTALL_ONE_FILE,libpanel,$(TARGET_DIR))
endef
define NCURSES_INSTALL_OPKG_PANEL
    $(call NCURSES_INSTALL_ONE_FILE,libpanel,$(BUILD_DIR_OPKG)/ncurses-$(NCURSES_VERSION))
endef
endif

ifeq ($(BR2_PACKAGE_NCURSES_TARGET_FORM),y)
define NCURSES_INSTALL_TARGET_FORM
    $(call NCURSES_INSTALL_ONE_FILE,libform,$(TARGET_DIR))
endef
define NCURSES_INSTALL_OPKG_FORM
    $(call NCURSES_INSTALL_ONE_FILE,libform,$(BUILD_DIR_OPKG)/ncurses-$(NCURSES_VERSION))
endef
endif

ifeq ($(BR2_PACKAGE_NCURSES_TARGET_MENU),y)
define NCURSES_INSTALL_TARGET_MENU
    $(call NCURSES_INSTALL_ONE_FILE,libmenu,$(TARGET_DIR))
endef
define NCURSES_INSTALL_OPKG_MENU
    $(call NCURSES_INSTALL_ONE_FILE,libmenu,$(BUILD_DIR_OPKG)/ncurses-$(NCURSES_VERSION))
endef
endif

define NCURSES_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib
	cp -dpf $(NCURSES_DIR)/lib/libncurses.so* $(TARGET_DIR)/usr/lib/
	$(NCURSES_INSTALL_TARGET_PANEL)
	$(NCURSES_INSTALL_TARGET_FORM)
	$(NCURSES_INSTALL_TARGET_MENU)
	ln -snf /usr/share/terminfo $(TARGET_DIR)/usr/lib/terminfo
	mkdir -p $(TARGET_DIR)/usr/share/terminfo/x
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/x/xterm $(TARGET_DIR)/usr/share/terminfo/x
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/x/xterm-color $(TARGET_DIR)/usr/share/terminfo/x
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/x/xterm-xfree86 $(TARGET_DIR)/usr/share/terminfo/x
	mkdir -p $(TARGET_DIR)/usr/share/terminfo/v
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/v/vt100 $(TARGET_DIR)/usr/share/terminfo/v
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/v/vt102 $(TARGET_DIR)/usr/share/terminfo/v
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/v/vt200 $(TARGET_DIR)/usr/share/terminfo/v
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/v/vt220 $(TARGET_DIR)/usr/share/terminfo/v
	mkdir -p $(TARGET_DIR)/usr/share/terminfo/a
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/a/ansi $(TARGET_DIR)/usr/share/terminfo/a
	mkdir -p $(TARGET_DIR)/usr/share/terminfo/l
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/l/linux $(TARGET_DIR)/usr/share/terminfo/l
	-$(STRIPCMD) $(STRIP_STRIP_UNNEEDED) $(TARGET_DIR)/usr/lib/libncurses.so*
	$(NCURSES_INSTALL_TARGET_DEVFILES)
endef # NCURSES_INSTALL_TARGET_CMDS

define NCURSES_BUILD_OPKG_CMDS
	mkdir -p $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/lib
	cp -dpf $(NCURSES_DIR)/lib/libncurses.so* $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/lib/
	cp -dpf $(NCURSES_DIR)/lib/libtinfo.so* $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/lib/
	$(NCURSES_INSTALL_OPKG_PANEL)
	$(NCURSES_INSTALL_OPKG_FORM)
	$(NCURSES_INSTALL_OPKG_MENU)
	ln -snf /usr/share/terminfo $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/lib/terminfo
	mkdir -p $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/x
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/x/xterm $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/x
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/x/xterm-color $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/x
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/x/xterm-xfree86 $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/x
	mkdir -p $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/v
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/v/vt100 $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/v
	mkdir -p $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/a
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/a/ansi $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/a
	mkdir -p $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/l
	cp -dpf $(STAGING_DIR)/usr/share/terminfo/l/linux $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/share/terminfo/l
	-$(STRIPCMD) $(STRIP_STRIP_UNNEEDED) $(BUILD_DIR_OPKG)/$(NCURSES_BASE_NAME)/usr/lib/libncurses.so*
	$(NCURSES_INSTALL_OPKG_DEVFILES)
endef # NCURSES_BUILD_OPKG_CMDS

$(eval $(call AUTOTARGETS,package,ncurses))
