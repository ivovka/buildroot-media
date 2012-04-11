#############################################################
#
# samba
#
#############################################################
SAMBA_VERSION:=3.5.12
SAMBA_SOURCE:=samba-$(SAMBA_VERSION).tar.gz
SAMBA_SITE:=http://samba.org/samba/ftp/stable/

SAMBA_SUBDIR = source3
SAMBA_AUTORECONF = NO

SAMBA_INSTALL_STAGING = YES
SAMBA_INSTALL_TARGET = YES
SAMBA_BUILD_OPKG = YES
SAMBA_SECTION = network
SAMBA_DESCRIPTION = The free SMB / CIFS fileserver and client
SAMBA_OPKG_DEPENDENCIES = sqlite
ifeq ($(BR2_PACKAGE_SAMBA_AVAHI),y)
SAMBA_OPKG_DEPENDENCIES += ,avahi
endif

SAMBA_DEPENDENCIES = \
	sqlite \
	$(if $(BR2_ENABLE_LOCALE),,libiconv) \
	$(if $(BR2_PACKAGE_SAMBA_RPCCLIENT),readline) \
	$(if $(BR2_PACKAGE_SAMBA_SMBCLIENT),readline) \
	$(if $(BR2_PACKAGE_SAMBA_AVAHI),avahi) \
	$(if $(BR2_PACKAGE_SAMBA_GAMIN),gamin)


SAMBA_CONF_ENV = \
	samba_cv_CC_NEGATIVE_ENUM_VALUES=no

ifeq ($(BR2_PACKAGE_SAMBA_AVAHI),y)
SAMBA_CONF_ENV += ac_cv_lib_avahi_client_avahi_client_new=yes
endif

SAMBA_CONF_OPT = \
        --localstatedir=/var \
        --sysconfdir=/etc \
        --with-configdir=/etc/samba \
        --with-privatedir=/var/run \
	--enable-shared \
	--disable-static \
	--enable-debug \
	--disable-krb5developer \
	--disable-picky-developer \
	--enable-largefile \
	--disable-socket-wrapper \
	--disable-nss-wrapper \
	$(if $(BR2_PACKAGE_SAMBA_SWAT),--enable-swat,--disable-swat) \
        --disable-cups \
        --disable-iprint \
        --enable-pie \
	--enable-relro \
	--enable-shared-libs \
	--disable-external-libtalloc \
	--disable-external-libtdb \
	$(if $(BR2_PACKAGE_SAMBA_GAMIN),--enable-fam,--disable-fam) \
	--disable-dnssd \
	$(if $(BR2_PACKAGE_SAMBA_AVAHI),--enable-avahi,--disable-avahi) \
	--disable-pthreadpool \
	--enable-gnutls \
	--disable-netapi \
	--disable-dmalloc \
	--with-fhs \
	--without-libtalloc \
	--without-libtdb \
	--without-libnetapi \
	--with-libsmbclient \
	--with-libsmbsharemodes \
        --without-libaddns \
        --without-afs \
        --without-fake-kaserver \
        --without-vfs-afsacl \
	--without-dce-dfs \
	--without-ldap \
	--without-ads \
	--with-dnsupdate \
	--without-automount \
	$(if $(BR2_PACKAGE_SAMBA_CIFS),--with-cifsmount,--without-cifsmount) \
	$(if $(BR2_PACKAGE_SAMBA_CIFS),--with-cifsumount,--without-cifsumount) \
	--without-cifsupcall \
	--without-pam \
	--without-pam_smbpass \
	--without-nisplus-home \
	--with-syslog \
	--without-quotas \
	--without-sys-quotas \
	--without-utmp \
	--without-cluster-support \
	--without-acl-support \
	--without-aio-support \
	--with-sendfile-support \
	--without-wbclient \
	$(if $(BR2_PACKAGE_SAMBA_WINBINDD),--with-winbind,--without-winbind) \
	--with-static-modules=charset_CP437,charset_CP850 \
	--with-included-popt \
	--with-included-iniparser \
	--with-libiconv=$(STAGING_DIR)/usr \
	--with-sqlite3 \
	--with-pthreads \
	--without-setproctitle 

define SAMBA_RUN_AUTOGEN
    (cd $(SAMBA_DIR)/$(SAMBA_SUBDIR) && \
    PATH=$(TARGET_PATH) ./autogen.sh \
    )
endef

SAMBA_PRE_CONFIGURE_HOOKS += SAMBA_RUN_AUTOGEN

SAMBA_MAKE_OPT = \
	bin/libsmbclient.so bin/smbd bin/nmbd bin/smbpasswd


#	-C $(SAMBA_DIR)/$(SAMBA_SUBDIR) \

define SAMBA_INSTALL_STAGING_CMDS
	(mkdir -p $(STAGING_DIR)/usr/lib && \
	cp -P $(SAMBA_DIR)/$(SAMBA_SUBDIR)/bin/*.so* $(STAGING_DIR)/usr/lib && \
	mkdir -p $(STAGING_DIR)/usr/include && \
	cp $(SAMBA_DIR)/$(SAMBA_SUBDIR)/include/libsmbclient.h $(STAGING_DIR)/usr/include && \
	mkdir -p $(STAGING_DIR)/usr/lib/pkgconfig && \
	cp $(SAMBA_DIR)/$(SAMBA_SUBDIR)/pkgconfig/smbclient.pc $(STAGING_DIR)/usr/lib/pkgconfig \
	)
endef

define SAMBA_INSTALL_TARGET_CMDS
	(mkdir -p $(TARGET_DIR)/usr/lib && \
	cp -P $(SAMBA_DIR)/$(SAMBA_SUBDIR)/bin/*.so* $(TARGET_DIR)/usr/lib && \
	mkdir -p $(TARGET_DIR)/usr/bin && \
	install -m 0755 $(SAMBA_DIR)/$(SAMBA_SUBDIR)/bin/smbd $(TARGET_DIR)/usr/bin && \
	install -m 0755 $(SAMBA_DIR)/$(SAMBA_SUBDIR)/bin/nmbd $(TARGET_DIR)/usr/bin \
	)
endef

define SAMBA_BUILD_OPKG_CMDS
	(mkdir -p $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/usr/lib && \
	cp -P $(SAMBA_DIR)/$(SAMBA_SUBDIR)/bin/*.so* $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/usr/lib && \
	mkdir -p $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/usr/bin && \
	install -m 0755 $(SAMBA_DIR)/$(SAMBA_SUBDIR)/bin/smbd $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/usr/bin && \
	install -m 0755 $(SAMBA_DIR)/$(SAMBA_SUBDIR)/bin/nmbd $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/usr/bin && \
	install -m 0755 $(SAMBA_DIR)/$(SAMBA_SUBDIR)/bin/smbpasswd $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/usr/bin && \
	mkdir -p $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/etc/samba && \
	cp $(TOPDIR)/package/samba/config/smb.conf $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/etc/samba && \
	mkdir -p $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/usr/config && \
	cp $(TOPDIR)/package/samba/config/smb.conf $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/usr/config/samba.conf.sample && \
	mkdir -p $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/etc/init.d && \
	cp $(TOPDIR)/package/samba/scripts/* $(BUILD_DIR_OPKG)/$(SAMBA_BASE_NAME)/etc/init.d \
	)
endef

define SAMBA_INSTALL_INITSCRIPTS_CONFIG
	# install start/stop script
	@if [ ! -f $(TARGET_DIR)/etc/init.d/S91smb ]; then \
		$(INSTALL) -m 0755 -D package/samba/S91smb $(TARGET_DIR)/etc/init.d/S91smb; \
	fi
	# install config
	@if [ ! -f $(TARGET_DIR)/etc/samba/smb.conf ]; then \
		$(INSTALL) -m 0755 -D package/samba/simple.conf $(TARGET_DIR)/etc/samba/smb.conf; \
	fi
endef

SAMBA_POST_INSTALL_TARGET_HOOKS += SAMBA_INSTALL_INITSCRIPTS_CONFIG

$(eval $(call AUTOTARGETS,package,samba))
