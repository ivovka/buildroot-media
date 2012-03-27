#############################################################
#
# lvm2
#
#############################################################
LVM2_VERSION = 2.02.84
LVM2_SOURCE = LVM2.$(LVM2_VERSION).tgz
LVM2_SITE = ftp://sources.redhat.com/pub/lvm2/releases
LVM2_INSTALL_STAGING = YES
LVM2_BUILD_OPKG = YES

LVM2_NAME_OPKG = lvm2
LVM2_SECTION = system
LVM2_DESCRIPTION = Logical Volume Management (Version 2)

LVM2_BINS = \
	dmsetup fsadm lvm lvmconf lvmdump vgimportclone \
	lvchange lvconvert lvcreate lvdisplay lvextend 	\
	lvmchange lvmdiskscan lvmsadc lvmsar lvreduce  	\
	lvremove lvrename lvresize lvs lvscan pvchange 	\
	pvck pvcreate pvdisplay pvmove pvremove 	\
	pvresize pvs pvscan vgcfgbackup vgcfgrestore 	\
	vgchange vgck vgconvert vgcreate vgdisplay 	\
	vgexport vgextend vgimport vgmerge vgmknodes 	\
	vgreduce vgremove vgrename vgs vgscan vgsplit

LVM2_CONF_ENV += ac_cv_func_malloc_0_nonnull=yes
# Make sure that binaries and libraries are installed with write
# permissions for the owner.
LVM2_CONF_OPT += \
    --enable-write_install \
    --disable-readline \
    --disable-lvm1_fallback \
    --disable-static_link \
    --enable-debug \
    --disable-profiling \
    --enable-devmapper \
    --disable-compat \
    --enable-o_direct \
    --enable-applib \
    --enable-cmdlib \
    --enable-pkgconfig \
    --enable-fsadm \
    --disable-dmeventd \
    --disable-selinux \
    --disable-nls

# LVM2 uses autoconf, but not automake, and the build system does not
# take into account the CC passed at configure time.
LVM2_MAKE_ENV = CC="$(TARGET_CC)"

ifeq ($(BR2_PACKAGE_LVM2_DMSETUP_ONLY),y)
LVM2_MAKE_OPT = device-mapper
LVM2_INSTALL_STAGING_OPT = DESTDIR=$(STAGING_DIR) install_device-mapper
LVM2_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install_device-mapper
endif

define LVM2_UNINSTALL_STAGING_CMDS
	rm -f $(addprefix $(STAGING_DIR)/usr/sbin/,$(LVM2_BINS))
	rm -f $(addprefix $(STAGING_DIR)/usr/lib/,libdevmapper.so*)
endef

define LVM2_UNINSTALL_TARGET_CMDS
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,$(LVM2_BINS))
	rm -f $(addprefix $(TARGET_DIR)/usr/lib/,libdevmapper.so*)
endef

define LVM2_INST_LIB
    mkdir -p $(1)/etc/lvm
    cp -P $(BUILD_DIR)/$(LVM2_BASE_NAME)/doc/example.conf $(1)/etc/lvm/lvm.conf
    mkdir -p $(1)/usr/lib
    cp -P $(BUILD_DIR)/$(LVM2_BASE_NAME)/libdm/ioctl/libdevmapper.so* $(1)/usr/lib
endef
ifeq ($(BR2_PACKAGE_LVM2_LIB_ONLY),y)
define LVM2_INSTALL_TARGET_CMDS
    $(call LVM2_INST_LIB,$(TARGET_DIR))
endef
define LVM2_BUILD_OPKG_CMDS
    $(call LVM2_INST_LIB,$(BUILD_DIR_OPKG)/$(LVM2_BASE_NAME))
endef
endif

$(eval $(call AUTOTARGETS,package,lvm2))
