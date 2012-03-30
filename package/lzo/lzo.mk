#############################################################
#
# lzo
#
#############################################################
LZO_VERSION = 2.06
LZO_SITE = http://www.oberhumer.com/opensource/lzo/download
LZO_INSTALL_STAGING = YES
LZO_BUILD_OPKG = YES

LZO_SECTION = compress
LZO_DESCRIPTION = LZO data compressor

$(eval $(call AUTOTARGETS,package,lzo))
$(eval $(call AUTOTARGETS,package,lzo,host))
