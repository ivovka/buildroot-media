#############################################################
#
# fftw
#
#############################################################

FFTW_VERSION = 3.3.2
FFTW_SOURCE = fftw-$(FFTW_VERSION).tar.gz
FFTW_SITE = http://www.fftw.org
FFTW_INSTALL_STAGING = YES
FFTW_INSTALL_TARGET = YES
FFTW_BUILD_OPKG = YES
FFTW_SECTION = "lang"
FFTW_DESCRIPTION = FFTW is a C subroutine library for computing the discrete Fourier transform (DFT) in one or more dimensions

FFTW_CONF_OPT = --enable-single \
  --enable-sse \
  --enable-sse2 \
  --disable-fortran \

$(eval $(call AUTOTARGETS,package,fftw))
