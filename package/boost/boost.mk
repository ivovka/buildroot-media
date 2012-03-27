#############################################################
#
# boost
#
#############################################################
BOOST_VERSION = 1_47_0
BOOST_VERSION_URL = 1.47.0
BOOST_SOURCE = boost_$(BOOST_VERSION).tar.bz2
BOOST_SITE = http://prdownloads.sourceforge.net/boost/boost/$(BOOST_VERSION_URL)
BOOST_INSTALL_STAGING = YES
BOOST_INSTALL_TARGET = YES
BOOST_BUILD_OPKG = YES

BOOST_SECTION = devel
BOOST_PRIORITY = important
BOOST_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
BOOST_DESCRIPTION = Peer-reviewed STL style libraries for C++
BOOST_OPKG_DEPENDENCIES = bzip2

BOOST_DEPENDENCIES = zlib bzip2 host-boost host-python

define BOOST_CONFIGURE_CMDS
    (cd $(BOOST_DIR) && \
    sh bootstrap.sh \
	--prefix=/usr \
	--with-bjam=$(HOST_DIR)/usr/bin/bjam \
	--with-python=$(HOST_DIR)/usr/bin/python && \
    echo "using gcc : `$(TARGET_CC) -v 2>&1  | tail -n 1 |awk '{print $$3}'` : $(TARGET_CC)  ; " \
	> tools/build/v2/user-config.jam \
    )
endef

define BOOST_BUILD_CMDS
    (cd $(BOOST_DIR) && \
    $(HOST_DIR)/usr/bin/bjam -d2 --toolset=gcc \
	link=shared \
	--prefix=$(STAGING_DIR)/usr \
	--layout=system \
	--with-thread \
	--with-iostreams \
	--with-system \
	--with-regex -sICU_PATH="$(STAGING_DIR)/usr" \
	install \
    )
endef

define BOOST_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/lib
    cp -P $(BOOST_DIR)/bin.v2/libs/*/build/*/release/*/*.so.* $(TARGET_DIR)/usr/lib
endef

define BOOST_BUILD_OPKG_CMDS
    mkdir -p $(BUILD_DIR_OPKG)/boost-$(BOOST_VERSION)/usr/lib
    cp -P $(BOOST_DIR)/bin.v2/libs/*/build/*/release/*/*.so.* $(BUILD_DIR_OPKG)/boost-$(BOOST_VERSION)/usr/lib
endef

define HOST_BOOST_BUILD_CMDS
    (cd $(HOST_BOOST_DIR)/tools/build/v2/engine && \
    sh build.sh \
    )
endef

define HOST_BOOST_INSTALL_CMDS
    (cd $(HOST_BOOST_DIR)/tools/build/v2/engine && \
    cp bin.*/bjam $(HOST_DIR)/usr/bin/ \
    )
endef
$(eval $(call GENTARGETS,package,boost))
$(eval $(call GENTARGETS,package,boost,host))
