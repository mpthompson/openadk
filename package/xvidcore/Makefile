# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		xvidcore
PKG_VERSION:=		1.3.3
PKG_RELEASE:=		1
PKG_HASH:=		9e6bb7f7251bca4615c2221534d4699709765ff019ab0366609f219b0158499d
PKG_DESCR:=		xvid codec library
PKG_SECTION:=		libs/video
PKG_URL:=		http://www.xvid.org/
PKG_SITES:=		http://downloads.xvid.org/downloads/
PKG_LIBNAME:=		libxvid
PKG_OPTS:=		dev

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

WRKDIST=		$(WRKDIR)/$(PKG_NAME)/build/generic

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,LIBXVID,libxvid,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION},${PKG_OPTS}))

libxvid-install:
	$(INSTALL_DIR) $(IDIR_LIBXVID)/usr/lib
	$(CP) $(WRKINST)/usr/lib/libxvidcore.so* \
		$(IDIR_LIBXVID)/usr/lib

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
