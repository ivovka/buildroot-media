#############################################################
#
# intltool
#
#############################################################
INTLTOOL_VERSION:=0.40.6
INTLTOOL_SOURCE:=intltool-$(INTLTOOL_VERSION).tar.bz2
INTLTOOL_SITE:=http://ftp.acc.umu.se/pub/GNOME/sources/intltool/0.40/

$(eval $(call AUTOTARGETS,package,intltool))
$(eval $(call AUTOTARGETS,package,intltool,host))

