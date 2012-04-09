#############################################################
#
# libcurl
#
#############################################################
LIBCURL_VERSION = 7.25.0
LIBCURL_SOURCE = curl-$(LIBCURL_VERSION).tar.bz2
LIBCURL_SITE = http://curl.haxx.se/download/
LIBCURL_INSTALL_STAGING = YES

LIBCURL_BUILD_OPKG = YES
LIBCURL_SECTION = libs
LIBCURL_PRIORITY = required
LIBCURL_DESCRIPTION = tool for getting files from FTP, HTTP, Gopher, Telnet and Dict servers, using any of the supported protocols.
LIBCURL_OPKG_DEPENDENCIES = zlib,openssl,rtmpdump
LIBCURL_DEPENDENCIES = host-autoconf host-m4 host-pkg-config rtmpdump zlib openssl

LIBCURL_CONF_ENV = LDFLAGS="$(TARGET_LDFLAGS) -lrt -lrtmp"
LIBCURL_CONF_ENV += ac_cv_lib_rtmp_RTMP_Init=yes \
    ac_cv_header_librtmp_rtmp_h=yes

LIBCURL_CONF_OPT += \
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
	    --enable-versioned-symbols \
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
	    --with-ssl \
            --with-zlib \
            --without-egd-socket \
            --enable-thread \
	    --with-random=/dev/urandom \
            --without-gnutls \
            --without-polarssl \
            --without-nss \
            --with-ca-bundle="/etc/ssl/cacert.pem" \
            --without-ca-path \
            --without-libssh2 \
            --with-librtmp="$(STAGING_DIR)/usr" \
            --without-libidn

define LIBCURL_TARGET_CLEANUP
	rm -rf $(TARGET_DIR)/usr/bin/curl-config \
	       $(if $(BR2_PACKAGE_CURL),,$(TARGET_DIR)/usr/bin/curl)
endef

define LIBCURL_OPKG_CLEANUP
	rm -rf $(BUILD_DIR_OPKG)/$(LIBCURL_BASE_NAME)/usr/bin/curl-config \
		$(if $(BR2_PACKAGE_CURL),,$(BUILD_DIR_OPKG)/$(LIBCURL_BASE_NAME)/usr/bin/curl)
endef

LIBCURL_POST_INSTALL_TARGET_HOOKS += LIBCURL_TARGET_CLEANUP
LIBCURL_PRE_BUILD_OPKG_HOOKS += LIBCURL_OPKG_CLEANUP

$(eval $(call AUTOTARGETS,package,libcurl))

curl: libcurl
curl-clean: libcurl-clean
curl-dirclean: libcurl-dirclean
curl-source: libcurl-source
