# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		xf86-input-keyboard
PKG_VERSION:=		1.8.1
PKG_RELEASE:=		1
PKG_HASH:=		8f7c645f4b17ed0a0607c92dfac87deafee9f3b975df6f87e0f606bab49e7754
PKG_DESCR:=		x11 driver for keyboard
PKG_SECTION:=		x11/drivers
PKG_DEPENDS:=		xorg-server
PKG_BUILDDEP:=		xorg-server
PKG_NEEDS:=		c++
PKG_SITES:=		http://www.x.org/releases/individual/driver/

DISTFILES:=		$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_CFLINE_XF86_INPUT_KEYBOARD:=	depends on ADK_TARGET_WITH_INPUT || ADK_TARGET_QEMU_WITH_GRAPHIC

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,XF86_INPUT_KEYBOARD,xf86-input-keyboard,$(PKG_VERSION)-$(PKG_RELEASE),$(PKG_DEPENDS),$(PKG_DESCR),$(PKG_SECTION)))

xf86-input-keyboard-install:
	$(INSTALL_DIR) $(IDIR_XF86_INPUT_KEYBOARD)/usr/lib/xorg/modules/input
	$(CP) $(WRKINST)/usr/lib/xorg/modules/input/kbd_drv.so \
		$(IDIR_XF86_INPUT_KEYBOARD)/usr/lib/xorg/modules/input/

include $(ADK_TOPDIR)/mk/pkg-bottom.mk
