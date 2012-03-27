#############################################################
#
# libcurl
#
#############################################################
LIBCURL_VERSION = 7.24.0
LIBCURL_SOURCE = curl-$(LIBCURL_VERSION).tar.bz2
LIBCURL_SITE = http://curl.haxx.se/download/
LIBCURL_INSTALL_STAGING = YES

LIBCURL_BUILD_OPKG = YES
LIBCURL_SECTION = libs
LIBCURL_PRIORITY = required
LIBCURL_DESCRIPTION = tool for getting files from FTP, HTTP, Gopher, Telnet and Dict servers, using any of the supported protocols.
LIBCURL_OPKG_DEPENDENCIES = rtmpdump

LIBCURL_CONF_ENV = LDFLAGS="$(TARGET_LDFLAGS) -lrt -lrtmp"
#LIBCURL_CONF_ENV = LDFLAGS="$(TARGET_LDFLAGS) -lrtmp"
LIBCURL_DEPENDENCIES = host-autoconf host-m4 host-pkg-config rtmpdump

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBCURL_DEPENDENCIES += openssl
LIBCURL_OPKG_DEPENDENCIES += ,openssl
LIBCURL_CONF_ENV += ac_cv_lib_crypto_CRYPTO_lock=yes
# configure adds the cross openssl dir to LD_LIBRARY_PATH which screws up
# native stuff during the rest of configure when target == host.
# Fix it by setting LD_LIBRARY_PATH to something sensible so those libs
# are found first.
LIBCURL_CONF_ENV += LD_LIBRARY_PATH=$$LD_LIBRARY_PATH:/lib:/usr/lib
LIBCURL_CONF_OPT += --with-ssl=$(STAGING_DIR)/usr --with-random=/dev/urandom
else
LIBCURL_CONF_OPT += --without-ssl
endif

LIBCURL_CONF_OPT += \
	    --disable-static \
	    --disable-debug \
            --enable-optimize \
            --enable-warnings \
            --disable-curldebug \
            --disable-ares \
            --enable-largefile \
            --enable-http \
            --enable-ftp \
            --enable-file \
            --disable-ldap \
            --disable-ldaps \
            --disable-rtsp \
            --enable-proxy \
            --disable-dict \
            --enable-telnet \
            --enable-tftp \
            --disable-pop3 \
            --disable-imap \
            --disable-smtp \
            --disable-gophper \
            --disable-manual \
            --enable-libgcc \
            --disable-ipv6 \
            --enable-nonblocking \
            --enable-threaded-resolver \
            --enable-verbose \
            --disable-sspi \
            --enable-crypto-auth \
            --enable-cookies \
            --enable-hidden-symbols \
            --disable-soname-bump \
            --without-krb4 \
            --without-spnego \
            --without-gssapi \
            --with-zlib \
            --without-egd-socket \
            --enable-thread \
            --without-gnutls \
            --without-polarssl \
            --without-nss \
            --with-ca-bundle="/etc/ssl/cacert.pem" \
            --without-ca-path \
            --without-libssh2 \
            --with-librtmp="$(STAGING_DIR)/usr" \
            --without-libidn

LIBCURL_CONF_ENV += ac_cv_lib_rtmp_RTMP_Init=yes \
    ac_cv_header_librtmp_rtmp_h=yes

define LIBCURL_TARGET_CLEANUP
	rm -rf $(TARGET_DIR)/usr/bin/curl-config \
	       $(if $(BR2_PACKAGE_CURL),,$(TARGET_DIR)/usr/bin/curl)
endef

define LIBCURL_OPKG_CLEANUP
	rm -rf $(BUILD_DIR_OPKG)/libcurl-$(LIBCURL_VERSION)/usr/bin/curl-config \
		$(if $(BR2_PACKAGE_CURL),,$(BUILD_DIR_OPKG)/libcurl-$(LIBCURL_VERSION)/usr/bin/curl)
endef

LIBCURL_POST_INSTALL_TARGET_HOOKS += LIBCURL_TARGET_CLEANUP
LIBCURL_PRE_BUILD_OPKG_HOOKS += LIBCURL_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package,libcurl))

curl: libcurl
curl-clean: libcurl-clean
curl-dirclean: libcurl-dirclean
curl-source: libcurl-source
