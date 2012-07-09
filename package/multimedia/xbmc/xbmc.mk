#############################################################
#
# xbmc
#
#############################################################
#XBMC_VERSION = g45c575b
# this is a new version but it works not very well: not usable after bufferization
#XBMC_VERSION = geb45e6f
XBMC_VERSION = g604577c
XBMC_SOURCE = opdenkamp-xbmc-$(XBMC_VERSION).tar.gz
XBMC_SITE = http://www.example.com
XBMC_INSTALL_STAGING = NO
XBMC_INSTALL_TARGET = YES
XBMC_BUILD_OPKG = YES
XBMC_SECTION = mediacenter
XBMC_DESCRIPTION = XBMC Mediacenter
XBMC_OPKG_DEPENDENCIES = boost,python,zlib,bzip2,lzo,pcre,alsa-lib,libass,enca,libssh,rtmpdump,fontconfig,fribidi,libpng,tiff,freetype,jasper,libmad,libsamplerate,libogg,libvorbis,libcdio,libmodplug,faad2,flac,lame,libmpeg2,sdl,sdl-mixer,sdl-image,sqlite,mysql,alsa-utils,bc,libx11,libxext,libxrandr,mesa,glew,dbus,libxt,libxmu,libbluray,samba,avahi,libnfs,libmicrohttpd,libvdpau,imaging,libplist,consolekit,yajl,simplejson,tinyxml
XBMC_DEPENDENCIES = boost python zlib bzip2 lzo pcre alsa-lib libass enca curl libssh rtmpdump dbus xlib_libX11 xlib_libXext dbus xlib_libXt xlib_libXtst xlib_libXmu xlib_libXrandr mesa3d glew fontconfig fribidi libpng tiff freetype jasper libmad libsamplerate libogg libvorbis libcdio libmodplug faad2 flac wavpack lame libmpeg2 libbluray sdl sdl_mixer sdl_image sqlite mysql samba avahi libmicrohttpd libvdpau imaging libplist ConsoleKit yajl libnfs tinyxml
XBMC_AUTORECONF = YES

define XBMC_AUTORECONF_LIBS
    cd $(XBMC_SRCDIR)/lib/libid3tag/libid3tag && $(AUTORECONF) $(XBMC_AUTORECONF_OPT)
    cd $(XBMC_SRCDIR)/xbmc/screensavers/rsxs-0.9 && $(AUTORECONF) $(XBMC_AUTORECONF_OPT)
    cd $(XBMC_SRCDIR)/lib/libapetag && $(AUTORECONF) $(XBMC_AUTORECONF_OPT)
    cd $(XBMC_SRCDIR)/lib/cpluff && $(AUTORECONF) $(XBMC_AUTORECONF_OPT)
    cd $(XBMC_SRCDIR)/lib/libdvd/libdvdcss && $(AUTORECONF) $(XBMC_AUTORECONF_OPT)
    cd $(XBMC_SRCDIR)/lib/libdvd/libdvdread && $(AUTORECONF) $(XBMC_AUTORECONF_OPT)
    cd $(XBMC_SRCDIR)/lib/libdvd/libdvdnav && $(AUTORECONF) $(XBMC_AUTORECONF_OPT)
    cd $(XBMC_SRCDIR) && find . -depth -type d -name "autom4te.cache" -exec rm -rf {} \;
endef

XBMC_PRE_CONFIGURE_HOOKS += XBMC_AUTORECONF_LIBS

# We must to define python includes as -I$(STAGING_DIR)/usr/include/python2.7
# python library path as -L$(STAGING_DIR)/usr/lib -lpython2.7
# Python site-packages path as $(STAGING_DIR)/usr/lib/python2.7/site-packages
# python extra libraries...  -lpthread -ldl  -lutil
# python extra linking flags... -Xlinker -export-dynamic
XBMC_CONF_ENV += PYTHON_NOVERSIONCHECK=YES \
    PYTHON_VERSION=$(PYTHON_VERSION_MAJOR) \
    PYTHON_CPPFLAGS="-I$(STAGING_DIR)/usr/include/python$(PYTHON_VERSION_MAJOR)" \
    PYTHON_LDFLAGS="-L$(STAGING_DIR)/usr/lib -lpython$(PYTHON_VERSION_MAJOR)" \
    PYTHON_SITE_PKG="$(STAGING_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages" \
    PYTHON_EXTRA_LIBS="-lpthread -ldl -lutil" \
    PYTHON_EXTRA_LDFLAGS="-Xlinker -export-dynamic" 
#    use_texturepacker_native=yes \
#    USE_TEXTUREPACKER_NATIVE_ROOT=$(HOST_DIR)/usr/bin

XBMC_CONF_OPT = \
    --enable-debug \
    --disable-optimizations \
    --enable-vdpau \
    --disable-vaapi \
    --disable-crystalhd \
    --disable-vdadecoder \
    --disable-vtbdecoder \
    --disable-openmax \
    --disable-joystick \
    --disable-ccache \
    --disable-pulse \
    --enable-rtmp \
    --enable-ffmpeg-libvorbis \
    --disable-hal \
    --enable-avahi \
    --enable-non-free \
    --disable-asap-codec \
    --enable-webserver \
    --disable-optical-drive \
    --enable-libbluray \
    --with-arch=$(ARCH) \
    --with-cpu=$(BR2_GCC_TARGET_TUNE) \
    --disable-texturepacker

define XBMC_CONFIG_PROJECTM
    (cd $(XBMC_SRCDIR)/xbmc/visualizations/XBMCProjectM/libprojectM && \
    rm -f CMakeCache.txt && \
    $(XBMC_CONF_ENV) $(HOST_DIR)/usr/bin/cmake $(XBMC_SRCDIR)/xbmc/visualizations/XBMCProjectM/libprojectM \
	-DCMAKE_TOOLCHAIN_FILE="$(BASE_DIR)/toolchainfile.cmake" \
	-DCMAKE_INSTALL_PREFIX="/usr" \
	-DUSE_FTGL:BOOL=OFF \
    )
endef

define XBMC_CONFIG_RSXS
    (cd $(XBMC_SRCDIR)/xbmc/screensavers/rsxs-0.9 && rm -rf config.cache && \
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_CONFIGURE_ARGS) \
    $(XBMC_CONF_ENV) \
    jm_cv_func_gettimeofday_clobber=no \
    ./configure \
	--target=$(GNU_TARGET_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) \
	--prefix=/usr \
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	$(SHARED_STATIC_LIBS_OPTS) \
	--without-xscreensaver \
	--disable-sound \
	--disable-cyclone \
	--disable-fieldlines \
	--disable-flocks \
	--disable-flux \
	--disable-helios \
	--disable-hyperspace \
	--disable-lattice \
	--disable-skyrocket \
	--with-png=$(STAGING_DIR)/usr \
    )
endef
#	--with-png-includes=$(STAGING_DIR)/usr/include/libpng14 \
#	--with-png-libraries=$(STAGING_DIR)/usr/lib \

define XBMC_COPY_SCRIPTS
    mkdir -p $(BUILD_DIR_OPKG)/$(XBMC_BASE_NAME)/usr/bin
    cp $(TOPDIR)/package/multimedia/xbmc/scripts/cputemp $(BUILD_DIR_OPKG)/$(XBMC_BASE_NAME)/usr/bin
    cp $(TOPDIR)/package/multimedia/xbmc/scripts/gputemp $(BUILD_DIR_OPKG)/$(XBMC_BASE_NAME)/usr/bin
    mkdir -p $(BUILD_DIR_OPKG)/$(XBMC_BASE_NAME)/etc/pm/sleep.d
    cp $(TOPDIR)/package/multimedia/xbmc/sleep.d/* $(BUILD_DIR_OPKG)/$(XBMC_BASE_NAME)/etc/pm/sleep.d
    mkdir -p $(BUILD_DIR_OPKG)/$(XBMC_BASE_NAME)/usr/share/xbmc/media/Fonts
    cp $(TOPDIR)/package/multimedia/xbmc/fonts/*.ttf $(BUILD_DIR_OPKG)/$(XBMC_BASE_NAME)/usr/share/xbmc/media/Fonts
endef

XBMC_POST_CONFIGURE_HOOKS += XBMC_CONFIG_PROJECTM
XBMC_POST_CONFIGURE_HOOKS += XBMC_CONFIG_RSXS
XBMC_PRE_BUILD_OPKG_HOOKS += XBMC_COPY_SCRIPTS

$(eval $(call AUTOTARGETS,package/multimedia,xbmc))
