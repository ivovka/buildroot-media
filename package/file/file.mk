#############################################################
#
# file
#
#############################################################

FILE_VERSION = 5.11
FILE_SITE = ftp://ftp.astron.com/pub/file/
FILE_DEPENDENCIES = host-file zlib
FILE_OPKG_DEPENDENCIES = zlib
HOST_FILE_DEPENDENCIES = host-zlib
FILE_BUILD_OPKG = YES

FILE_SECTION = devel
FILE_DESCRIPTION = File type identification utility

FILE_CONF_OPT = --enable-fsect-man5

HOST_FILE_CONF_OPT = --enable-fsect-man5

define FILE_UNINSTALL_TARGET_CMDS
	$(MAKE) DESTDIR=$(TARGET_DIR) uninstall -C $(FILE_DIR)
	rm -f $(TARGET_DIR)/usr/lib/libmagic.*
endef

$(eval $(call AUTOTARGETS,package,file))
$(eval $(call AUTOTARGETS,package,file,host))
