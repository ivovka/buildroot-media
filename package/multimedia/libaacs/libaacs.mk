#############################################################
#
# libaacs
#
#############################################################

LIBAACS_VERSION = 0.3.0
LIBAACS_SOURCE = libaacs-$(LIBAACS_VERSION).tar.bz2
LIBAACS_SITE = ftp://ftp.videolan.org/pub/videolan/libaacs/$(LIBAACS_VERSION)
LIBAACS_INSTALL_STAGING = YES
LIBAACS_BUILD_OPKG = YES
LIBAACS_SECTION = multimedia
LIBAACS_DESCRIPTION = research project to implement the Advanced Access Content System specification
LIBAACS_DEPENDENCIES = libgcrypt
LIBAACS_OPKG_DEPENDENCIES = libgcrypt

LIBAACS_CONF_OPT = \
  --disable-werror \
  --disable-extra-warnings \
  --disable-optimizations \
  --disable-examples

$(eval $(call AUTOTARGETS,package/multimedia,libaacs))
