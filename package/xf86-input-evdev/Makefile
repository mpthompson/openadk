# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		xf86-input-evdev
PKG_VERSION:=		2.7.0
PKG_RELEASE:=		1
PKG_HASH:=		cf4bdbd4b40f05d4e29cd6494c64f092667202b0834c54bdaed448463622807b
PKG_DESCR:=		x11 driver for evdev
PKG_SECTION:=		x11/drivers
PKG_DEPENDS:=		xorg-server libudev
PKG_BUILDDEP:=		xorg-server eudev
PKG_SITES:=		http://www.x.org/releases/individual/driver/

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz
PKG_LIBC_DEPENDS:=	glibc
PKG_ARCH_DEPENDS:=	!m68k

PKG_CFLINE_XF86_INPUT_EVDEV:= depends on ADK_TARGET_WITH_INPUT

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,XF86_INPUT_EVDEV,xf86-input-evdev,$(PKG_VERSION)-$(PKG_RELEASE),${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

xf86-input-evdev-install:
	${INSTALL_DIR} ${IDIR_XF86_INPUT_EVDEV}/usr/lib/xorg/modules/input
	${CP} ${WRKINST}/usr/lib/xorg/modules/input/evdev_drv.so \
		${IDIR_XF86_INPUT_EVDEV}/usr/lib/xorg/modules/input/

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
