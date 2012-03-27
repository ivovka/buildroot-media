############################################################
#
# yasm
#
############################################################

YASM_VERSION=1.2.0
YASM_SOURCE=yasm-$(YASM_VERSION).tar.gz
YASM_SITE=http://www.tortall.net/projects/yasm/releases

YASM_CONF_OPT = \
	--disable-debug \
	--disable-warnerror \
	--disable-profiling \
	--disable-gcov \
	--disable-python \
	--disable-python-bindings \
	--enable-nls \
	--disable-rpath \
	--without-dmalloc \
	--with-gnu-ld \
	--without-libiconv-prefix \
	--without-libintl-prefix

$(eval $(call AUTOTARGETS,package,yasm))
$(eval $(call AUTOTARGETS,package,yasm,host))
