#############################################################
#
# pthread-stubs
#
#############################################################
PTHREAD_STUBS_VERSION = 0.3
PTHREAD_STUBS_SOURCE = libpthread-stubs-$(PTHREAD_STUBS_VERSION).tar.bz2
PTHREAD_STUBS_SITE = http://xcb.freedesktop.org/dist/

PTHREAD_STUBS_INSTALL_STAGING = YES
PTHREAD_STUBS_BUILD_OPKG = NO

PTHREAD_STUBS_SECTION = devel
PTHREAD_STUBS_DESCRIPTION = A library providing weak aliases for pthread functions

$(eval $(call AUTOTARGETS,package/x11r7,pthread-stubs))
$(eval $(call AUTOTARGETS,package/x11r7,pthread-stubs,host))

