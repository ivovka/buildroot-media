#############################################################
#
# opkg
#
#############################################################

OPKG_VERSION = 635
OPKG_SITE = http://opkg.googlecode.com/svn/trunk/
OPKG_SITE_METHOD = svn
OPKG_AUTORECONF = YES
OPKG_DEPENDENCIES = host-pkg-config openssl curl
OPKG_BUILD_OPKG = YES
OPKG_SECTION = admin
OPKG_PRIORITY = required
OPKG_DESCRIPTION = lightweight package management system based on Ipkg.
OPKG_OPKG_DEPENDENCIES = linux,libc,busybox,openssl,libcurl
OPKG_CONF_OPT = \
    --disable-static \
    --disable-pathfinder \
    --enable-curl \
    --enable-ssl-curl \
    --enable-openssl \
    --disable-sha256 \
    --disable-gpg \
    --with-opkglibdir=/usr/lib \
    --with-opkgetcdir=/etc \
    --with-opkglockfile=/var/lock/opkg.lock

$(eval $(call AUTOTARGETS,package,opkg))
