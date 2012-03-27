#############################################################
#
# libc only for build opkg
#
#############################################################
LIBC_VERSION = 2.13
LIBC_INSTALL_STAGING = NO
LIBC_INSTALL_TARGET = NO
LIBC_BUILD_OPKG = YES
LIBC_SECTION = system
LIBC_PRIORITY = required
LIBC_DESCRIPTION = C library package (eglibc)

TOOLCHAIN_EXTERNAL_PREFIX=$(call qstrip,$(BR2_TOOLCHAIN_EXTERNAL_PREFIX))
ifeq ($(BR2_TOOLCHAIN_EXTERNAL_DOWNLOAD),y)
TOOLCHAIN_EXTERNAL_DIR=$(HOST_DIR)/opt/ext-toolchain
else
TOOLCHAIN_EXTERNAL_DIR=$(call qstrip,$(BR2_TOOLCHAIN_EXTERNAL_PATH))
endif
ifeq ($(TOOLCHAIN_EXTERNAL_DIR),)
# if no path set, figure it out from path
TOOLCHAIN_EXTERNAL_BIN:=$(shell dirname $(shell which $(TOOLCHAIN_EXTERNAL_PREFIX)-gcc))
else
TOOLCHAIN_EXTERNAL_BIN:=$(TOOLCHAIN_EXTERNAL_DIR)/bin
endif
TOOLCHAIN_EXTERNAL_CROSS=$(TOOLCHAIN_EXTERNAL_BIN)/$(TOOLCHAIN_EXTERNAL_PREFIX)-
TOOLCHAIN_EXTERNAL_CC=$(TOOLCHAIN_EXTERNAL_CROSS)gcc
SYSROOT_DIR=`$(TOOLCHAIN_EXTERNAL_CC) -print-sysroot 2>/dev/null`

LIB_EXTERNAL_LIBS=ld-$(LIBC_VERSION).so lib*.so
LIB_EXTERNAL_LIBS+=libnss_files*.so libnss_dns*.so

$(BUILD_DIR)/../stamps/.libc-target-installed:
	touch $@

$(BIN_DIR_OPKG)/libc-$(LIBC_VERSION):
	$(Q)mkdir -p $(BINARIES_DIR_OPKG)
	scripts/opkg-build -c -o 0 -g 0 -O $(OPKGBDNAME) $(BINARIES_DIR_OPKG)
	$(Q)touch $@

$(BUILD_DIR_OPKG)/libc-$(LIBC_VERSION):
	$(Q)mkdir -p $(@D)/libc-$(LIBC_VERSION)/CONTROL
	echo "Package: libc" > $(@D)/libc-$(LIBC_VERSION)/CONTROL/control
	echo "Version: $(LIBC_VERSION)" >> $(@D)/libc-$(LIBC_VERSION)/CONTROL/control
	echo "Architecture: $(ARCH)" >> $(@D)/libc-$(LIBC_VERSION)/CONTROL/control
	echo "Maintainer: Vladimir Ivakin vladimir_iva@pisem.net" >> $(@D)/libc-$(LIBC_VERSION)/CONTROL/control
	echo -e "Description: $(LIBC_DESCRIPTION)" >> $(@D)/libc-$(LIBC_VERSION)/CONTROL/control
	echo "Section: $(LIBC_SECTION)" >> $(@D)/libc-$(LIBC_VERSION)/CONTROL/control
	echo "Priority: $(LIBC_PRIORITY)" >> $(@D)/libc-$(LIBC_VERSION)/CONTROL/control
	echo "Source: eglibc" >> $(@D)/libc-$(LIBC_VERSION)/CONTROL/control
	echo "Depends: " >> $(@D)/libc-$(LIBC_VERSION)/CONTROL/control
	mkdir -p $(@D)/libc-$(LIBC_VERSION)/usr/lib
	mkdir -p $(@D)/libc-$(LIBC_VERSION)/lib
	cp -d $(SYSROOT_DIR)/lib/ld*.so* $(@D)/libc-$(LIBC_VERSION)/lib
	cp -d $(SYSROOT_DIR)/lib/lib*.so* $(@D)/libc-$(LIBC_VERSION)/lib
	cp -d $(SYSROOT_DIR)/usr/lib/lib*.so* $(@D)/libc-$(LIBC_VERSION)/usr/lib

$(BINARIES_DIR_OPKG)/libc_$(LIBC_VERSION)_$(ARCH).opk: $(BUILD_DIR_OPKG)/libc-$(LIBC_VERSION)
	scripts/opkg-build -c -o 0 -g 0 -O $(BUILD_DIR_OPKG)/libc-$(LIBC_VERSION) $(BINARIES_DIR_OPKG)
	$(Q)touch $@

$(BUILD_DIR)/../stamps/.libc-opkg-built: $(BINARIES_DIR_OPKG)/libc_$(LIBC_VERSION)_$(ARCH).opk
	touch $@

libc-install-target: $(BUILD_DIR)/../stamps/.libc-target-installed

libc-build-opkg: $(BUILD_DIR)/../stamps/.libc-opkg-built

libc: libc-install-target libc-build-opkg

libc-clean:
	- rm $(BUILD_DIR)/stamps/.libc-target-installed
	- rm $(BUILD_DIR)/stamps/.libc-opkg-build
	- rm -rf $(BINARIES_DIR_OPKG)/libc_$(LIBC_VERSION)_$(ARCH).opk
	- rm -rf $(BUILD_DIR_OPKG)/libc-$(LIBC_VERSION)

TARGETS += libc
