# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		htop
PKG_VERSION:=		2.0.1
PKG_RELEASE:=		1
PKG_HASH:=		f410626dfaf6b70fdf73cd7bb33cae768869707028d847fed94a978e974f5666
PKG_DESCR:=		graphical process manager
PKG_SECTION:=		sys/utils
PKG_DEPENDS:=		libncurses
PKG_BUILDDEP:=		ncurses
PKG_URL:=		http://hisham.hm/htop
PKG_SITES:=		http://hisham.hm/htop/releases/$(PKG_VERSION)/

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,HTOP,htop,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

TARGET_LDFLAGS+=	-ltinfo
CONFIGURE_ENV+= 	ac_cv_file__proc_stat=yes \
		  	ac_cv_file__proc_meminfo=yes
CONFIGURE_ARGS+=	--disable-unicode

htop-install:
	$(INSTALL_DIR) $(IDIR_HTOP)/usr/bin
	$(INSTALL_BIN) $(WRKINST)/usr/bin/htop $(IDIR_HTOP)/usr/bin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
