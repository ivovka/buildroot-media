#############################################################
#
# transmission
#
#############################################################
TRANSMISSION_VERSION = 2.42
TRANSMISSION_SOURCE = transmission-$(TRANSMISSION_VERSION).tar.bz2
TRANSMISSION_SITE = http://download.transmissionbt.com/files/
TRANSMISSION_INSTALL_STAGING = NO
TRANSMISSION_INSTALL_TARGET = YES
TRANSMISSION_BUILD_OPKG = YES
TRANSMISSION_SECTION = net
TRANSMISSION_DESCRIPTION = Transmission is a cross-platform BitTorrent client
TRANSMISSION_OPKG_DEPENDENCIES = libevent
TRANSMISSION_DEPENDENCIES = curl zlib libevent openssl host-pkg-config

TRANSMISSION_CONF_OPT = \
  HAVE_CXX=yes \
  --disable-libnotify \
  --enable-lightweight \
  --disable-gtk \
  --disable-nls

ifeq ($(BR2_PACKAGE_TRANSMISSION_UTP),y)
  TRANSMISSION_CONF_OPT += --enable-utp
else
  TRANSMISSION_CONF_OPT += --disable-utp
endif

ifeq ($(BR2_PACKAGE_TRANSMISSION_CLI),y)
  TRANSMISSION_CONF_OPT += --enable-cli
else
  TRANSMISSION_CONF_OPT += --disable-cli
endif

ifeq ($(BR2_PACKAGE_TRANSMISSION_DAEMON),y)
  TRANSMISSION_CONF_OPT += --enable-daemon
else
  TRANSMISSION_CONF_OPT += --disable-daemon
endif

define TRANSMISSION_RM_BINS
  rm -f $(BUILD_DIR_OPKG)/$(TRANSMISSION_BASE_NAME)/usr/bin/transmission-{cli,create,edit,remote,show}
endef

TRANSMISSION_PRE_BUILD_OPKG_HOOKS += TRANSMISSION_RM_BINS

$(eval $(call AUTOTARGETS,package,transmission))
