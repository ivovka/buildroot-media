#############################################################
#
# swig
#
#############################################################
SWIG_VERSION = 2.0.8
SWIG_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/swig
SWIG_SOURCE = swig-$(SWIG_VERSION).tar.gz
SWIG_INSTALL_STAGING = NO
SWIG_INSTALL_TARGET = NO
SWIG_BUILD_OPKG = NO

HOST_SWIG_DEPENDENCIES = host-pkg-config

SWIG_SECTION = devel
SWIG_DESCRIPTION = SWIG is a software development tool that connects programs written in C and C++ with a variety of high-level programming languages.

HOST_SWIG_CONF_OPT = --with-boost=no \
  --without-x \
  --without-tcl \
  --without-python \
  --without-python3 \
  --without-perl5 \
  --without-octave \
  --without-java \
  --without-gcj \
  --without-android \
  --without-guile \
  --without-mzscheme \
  --without-ruby \
  --without-php \
  --without-ocaml \
  --without-pike \
  --without-chicken \
  --without-csharp \
  --without-lua \
  --without-allegrocl \
  --without-clisp \
  --without-r \
  --without-go \
  --without-d 

$(eval $(call AUTOTARGETS,package,swig,host))
