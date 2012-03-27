#############################################################
#
# libplist
#
#############################################################
LIBPLIST_VERSION = 1.3
LIBPLIST_SOURCE = libplist-$(LIBPLIST_VERSION).tar.bz2
LIBPLIST_SITE = http://github.com/downloads/JonathanBeck/libplist
LIBPLIST_INSTALL_STAGING = YES
LIBPLIST_INSTALL_TARGET = YES
LIBPLIST_BUILD_OPKG = YES
LIBPLIST_SECTION = devel
LIBPLIST_DESCRIPTION = a library for manipulating Apple Binary and XML Property Lists
LIBPLIST_OPKG_DEPENDENCIES = libxml2,libglib2,pcre
LIBPLIST_DEPENDENCIES = libxml2 libglib2 pcre
LIBPLIST_CONF_OPT = -DENABLE_PYTHON="OFF"
$(eval $(call CMAKETARGETS,package,libplist))
