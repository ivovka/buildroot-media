#############################################################
#
# libusb-compat
#
#############################################################
LIBUSB_COMPAT_VERSION = 0.1.3
LIBUSB_COMPAT_SOURCE = libusb-compat-$(LIBUSB_COMPAT_VERSION).tar.bz2
LIBUSB_COMPAT_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/project/libusb/libusb-compat-0.1/libusb-compat-$(LIBUSB_COMPAT_VERSION)
LIBUSB_COMPAT_DEPENDENCIES = host-pkg-config libusb
LIBUSB_COMPAT_INSTALL_STAGING = YES
LIBUSB_COMPAT_INSTALL_TARGET = YES
LIBUSB_COMPAT_BUILD_OPKG = YES

LIBUSB_COMPAT_SECTION = system
LIBUSB_COMPAT_PRIORITY = optional
LIBUSB_COMPAT_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
LIBUSB_COMPAT_DESCRIPTION = OS independent USB device access
LIBUSB_COMPAT_OPKG_DEPENDENCIES = libusb

define LIBUSB_COMPAT_FIXUP_CONFIG
	$(SED) 's%prefix=/usr%prefix=$(STAGING_DIR)/usr%' \
	    -e 's%exec_prefix=/usr%exec_prefix=$(STAGING_DIR)/usr%' \
		$(STAGING_DIR)/usr/bin/libusb-config
endef

LIBUSB_COMPAT_POST_INSTALL_STAGING_HOOKS+=LIBUSB_COMPAT_FIXUP_CONFIG

$(eval $(call AUTOTARGETS,package,libusb-compat))
