#############################################################
#
# polkit
#
#############################################################

POLKIT_VERSION = 0.101
POLKIT_SITE = http://hal.freedesktop.org/releases
POLKIT_INSTALL_STAGING = YES
POLKIT_BUILD_OPKG = YES
POLKIT_DEPENDENCIES = zlib sg3_utils libglib2 udev eggdbus expat gobject-introspection
POLKIT_OPKG_DEPENDENCIES = sg3-utils,libglib2,udev,eggdbus,expat

POLKIT_SECTION = security
POLKIT_DESCRIPTION = Authorization Toolkit

POLKIT_CONF_OPT = \
    --libexecdir=/usr/lib/polkit-1 \
    --disable-man-pages \
    --disable-nls \
    --disable-introspection \
    --with-authfw=shadow \
    --with-os-type=redhat

define POLKIT_CP_OPKG_SCRIPTS
    mkdir -p $(BUILD_DIR_OPKG)/$(POLKIT_BASE_NAME)/CONTROL
    cp $(TOPDIR)/package/polkit/opkg-postinst $(BUILD_DIR_OPKG)/$(POLKIT_BASE_NAME)/CONTROL/postinst
endef

POLKIT_PRE_BUILD_OPKG_HOOKS += POLKIT_CP_OPKG_SCRIPTS

$(eval $(call AUTOTARGETS,package,polkit))
