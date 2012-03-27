#############################################################
#
# mesa3d
#
#############################################################
#MESA3D_VERSION:=7.11-rc3
MESA3D_VERSION:=8.0.1
MESA3D_SOURCE:=MesaLib-$(MESA3D_VERSION).tar.bz2
MESA3D_SITE:=ftp://ftp.freedesktop.org/pub/mesa/8.0.1

MESA3D_BUILD_OPKG = YES
MESA3D_NAME_OPKG = mesa
MESA3D_SECTION = graphics
MESA3D_DESCRIPTION = 3-D graphics library with OpenGL API
MESA3D_OPKG_DEPENDENCIES = libxext,libxcb,libx11,libxxf86vm,libxdamage,libxfixes,libdrm,expat,libvdpau

MESA3D_AUTORECONF = YES
MESA3D_CONF_ENV += \
    HOST_CC="$(HOSTCC)" \
    HOST_OPT_FLAGS="$(HOST_CFLAGS)" \
    X11_INCLUDES= \
    DRI_DRIVER_INSTALL_DIR="/usr/lib/dri" \
    DRI_DRIVER_SEARCH_DIR="/usr/lib/dri"
MESA3D_CONF_OPT = \
    --disable-gallium-llvm \
    --disable-debug \
    --enable-texture-float \
    --disable-selinux \
    --enable-opengl \
    --enable-glx-tls \
    --enable-driglx-direct \
    --disable-gles1 \
    --disable-gles2 \
    --disable-openvg \
    --disable-xorg \
    --enable-glu \
    --disable-gl-osmesa \
    --disable-glut \
    --disable-glw \
    --disable-motif \
    --disable-d3d1x \
    --disable-egl \
    --disable-gbm \
    --disable-gallium-egl \
    --disable-gallium-gbm \
    --disable-shared-glapi \
    --enable-xcb \
    --disable-shared-dricore \
    --with-driver=dri \
    --with-gallium-drivers="" \
    --with-dri-drivers="" \
    --disable-static \
    --enable-vdpau

MESA3D_INSTALL_STAGING = YES

define MESA3D_BUILD_BUILTIN_COMPILER
    $(HOST_MAKE_ENV) $(MESA3D_MAKE_ENV) \
    $(HOST_CONFIGURE_OPTS) \
    CFLAGS="$(HOST_CFLAGS)" \
    LDFLAGS="$(HOST_LDFLAGS)" \
    $(MESA3D_MAKE) $(MESA3D_MAKE_OPT) \
    CC="$(HOSTCC)" CXX="$(HOSTCXX)" CFLAGS="$(HOST_CFLAGS)" CXXFLAGS="$(HOST_CXXFLAGS)" LDFLAGS="$(HOST_LDFLAGS)" \
    -C $(MESA3D_SRCDIR)/src/glsl builtin_compiler
    cp $(MESA3D_SRCDIR)/src/glsl/builtin_compiler $(HOST_DIR)/usr/bin
    $(HOST_MAKE_ENV) $(MESA3D_MAKE_ENV) $(MESA3D_MAKE) $(MESA3D_MAKE_OPT) -C $(MESA3D_SRCDIR)/src/glsl clean
    $(SED) "s#\.\/builtin_compiler#$(HOST_DIR)/usr/bin/builtin_compiler#g" $(MESA3D_SRCDIR)/src/glsl/Makefile
endef

MESA3D_POST_CONFIGURE_HOOKS += MESA3D_BUILD_BUILTIN_COMPILER

MESA3D_DEPENDENCIES = python host-xutil_makedepend xproto_glproto xlib_libXext libxcb xlib_libX11 xlib_libXxf86vm xlib_libXdamage xlib_libXfixes xproto_dri2proto libdrm expat libvdpau

$(eval $(call AUTOTARGETS,package/x11r7,mesa3d))
