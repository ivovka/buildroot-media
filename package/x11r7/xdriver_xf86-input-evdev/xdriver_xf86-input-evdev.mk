################################################################################
#
# xdriver_xf86-input-evdev -- Generic Linux input driver
#
################################################################################

XDRIVER_XF86_INPUT_EVDEV_VERSION = 2.6.0
XDRIVER_XF86_INPUT_EVDEV_SOURCE = xf86-input-evdev-$(XDRIVER_XF86_INPUT_EVDEV_VERSION).tar.bz2
XDRIVER_XF86_INPUT_EVDEV_SITE = http://xorg.freedesktop.org/releases/individual/driver
XDRIVER_XF86_INPUT_EVDEV_AUTORECONF = NO
XDRIVER_XF86_INPUT_EVDEV_DEPENDENCIES = xutil_util-macros xproto_inputproto xproto_randrproto xproto_xproto
XDRIVER_XF86_INPUT_EVDEV_BUILD_OPKG = YES
XDRIVER_XF86_INPUT_EVDEV_NAME_OPKG = xf86-input-evdev
XDRIVER_XF86_INPUT_EVDEV_SECTION = x11
XDRIVER_XF86_INPUT_EVDEV_DESCRIPTION = Generic Xorg Linux input driver
XDRIVER_XF86_INPUT_EVDEV_CONF_OPT = --with-xorg-module-dir=/usr/lib/xorg/modules

$(eval $(call AUTOTARGETS,package/x11r7,xdriver_xf86-input-evdev))
