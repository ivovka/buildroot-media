#############################################################
#
# swh-plugins
#
#############################################################
SWH_PLUGINS_VERSION = 0.4.15
SWH_PLUGINS_SOURCE = swh-plugins-$(SWH_PLUGINS_VERSION).tar.gz
SWH_PLUGINS_SITE = http://plugin.org.uk/releases/$(SWH_PLUGINS_VERSION)
SWH_PLUGINS_INSTALL_STAGING = NO
SWH_PLUGINS_BUILD_OPKG = YES

SWH_PLUGINS_SECTION = audio
SWH_PLUGINS_DESCRIPTION = LADSPA plugins
SWH_PLUGINS_OPKG_DEPENDENCIES = alsa-lib,fftw
SWH_PLUGINS_DEPENDENCIES = alsa-lib fftw
SWH_PLUGINS_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -march=atom"
SWH_PLUGINS_CONF_OPT += --localstatedir=/var \
	--disable-nls \
	--enable-sse \
	--without-libiconv-prefix \
	--without-libintl-prefix \


$(eval $(call AUTOTARGETS,package/multimedia,swh-plugins))
