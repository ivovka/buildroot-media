################################################################################
#
# faad2
#
################################################################################

FAAD2_VERSION = 2.7
FAAD2_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/faac
FAAD2_INSTALL_STAGING = YES
FAAD2_BUILD_OPKG = YES
FAAD2_AUTORECONF = YES

FAAD2_SECTION = libs
FAAD2_PRIORITY = optional
FAAD2_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
FAAD2_DESCRIPTION = FAAD2 is an open source MPEG-4 and MPEG-2 AAC decoder

FAAD2_CONF_OPT = --without-xmms \
	--without-drm \
	--without-mpeg4ip

$(eval $(call AUTOTARGETS,package/multimedia,faad2))
