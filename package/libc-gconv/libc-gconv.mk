#############################################################
#
# libc-gconv
#
#############################################################
LIBC_GCONV_VERSION = 2.13
LIBC_GCONV_INSTALL_STAGING = NO
LIBC_GCONV_INSTALL_TARGET = YES
LIBC_GCONV_BUILD_OPKG = YES
LIBC_GCONV_SECTION = system
LIBC_GCONV_PRIORITY = important
LIBC_GCONV_DESCRIPTION = Gconv conversion modules from libc

$(BUILD_DIR)/../stamps/.libc-gconv-target-installed:
	mkdir -p $(TARGET_DIR)/usr/lib
	cp -d -p -r $(STAGING_DIR)/usr/lib/gconv $(TARGET_DIR)/usr/lib
	mkdir -p $(TARGET_DIR)/usr/share
	cp -d -p -r $(STAGING_DIR)/usr/share/i18n $(TARGET_DIR)/usr/share
	mkdir -p $(TARGET_DIR)/usr/bin
	cp $(STAGING_DIR)/usr/bin/{locale,localedef} $(TARGET_DIR)/usr/bin
	touch $@

$(BIN_DIR_OPKG)/libc-gconv-$(LIBC_GCONV_VERSION):
	$(Q)mkdir -p $(BINARIES_DIR_OPKG)
	scripts/opkg-build -c -o 0 -g 0 -O $(OPKGBDNAME) $(BINARIES_DIR_OPKG)
	$(Q)touch $@

$(BUILD_DIR_OPKG)/libc-gconv-$(LIBC_GCONV_VERSION):
	$(Q)mkdir -p $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL
	echo "Package: libc-gconv" > $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL/control
	echo "Version: $(LIBC_GCONV_VERSION)" >> $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL/control
	echo "Architecture: $(ARCH)" >> $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL/control
	echo "Maintainer: Vladimir Ivakin vladimir_iva@pisem.net" >> $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL/control
	echo -e "Description: $(LIBC_GCONV_DESCRIPTION)" >> $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL/control
	echo "Section: $(LIBC_GCONV_SECTION)" >> $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL/control
	echo "Priority: $(LIBC_GCONV_PRIORITY)" >> $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL/control
	echo "Source: eglibc" >> $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL/control
	echo "Depends: " >> $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/CONTROL/control
	mkdir -p $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/usr/lib
	cp -d -p -r $(STAGING_DIR)/usr/lib/gconv $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/usr/lib
	mkdir -p $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/usr/share
	cp -d -p -r $(STAGING_DIR)/usr/share/i18n $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/usr/share
	mkdir -p $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/usr/bin
	cp $(STAGING_DIR)/usr/bin/{locale,localedef} $(@D)/libc-gconv-$(LIBC_GCONV_VERSION)/usr/bin

$(BINARIES_DIR_OPKG)/libc-gconv_$(LIBC_GCONV_VERSION)_$(ARCH).opk: $(BUILD_DIR_OPKG)/libc-gconv-$(LIBC_GCONV_VERSION)
	scripts/opkg-build -c -o 0 -g 0 -O $(BUILD_DIR_OPKG)/libc-gconv-$(LIBC_GCONV_VERSION) $(BINARIES_DIR_OPKG)
	$(Q)touch $@

$(BUILD_DIR)/../stamps/.libc-gconv-opkg-built: $(BINARIES_DIR_OPKG)/libc-gconv_$(LIBC_GCONV_VERSION)_$(ARCH).opk
	touch $@

libc-gconv-install-target: $(BUILD_DIR)/../stamps/.libc-gconv-target-installed

libc-gconv-build-opkg: $(BUILD_DIR)/../stamps/.libc-gconv-opkg-built

libc-gconv: libc-gconv-install-target libc-gconv-build-opkg

libc-gconv-clean:
	rm $(BUILD_DIR)/stamps/.libc-gconv-target-installed
	rm $(BUILD_DIR)/stamps/.libc-gconv-opkg-built

TARGETS += libc-gconv
