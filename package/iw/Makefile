# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		iw
PKG_VERSION:=		4.7
PKG_RELEASE:=		1
PKG_HASH:=		d1720c04bc26661d42e71d13746d5c3aeedb6bdf743f7d6b7b056f0abd345ee8
PKG_DESCR:=		tools for setting up wifi cards
PKG_SECTION:=		net/wifi
PKG_DEPENDS:=		libnl
PKG_BUILDDEP:=		libnl
PKG_NEEDS:=		threads
PKG_URL:=		http://wireless.kernel.org/en/users/Documentation/iw
PKG_SITES:=		https://www.kernel.org/pub/software/network/iw/

PKG_DFLT_IW:=		y if ADK_TARGET_WITH_WIFI

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,IW,iw,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

TARGET_CFLAGS+=		$(TARGET_CPPFLAGS)
CONFIG_STYLE:=		manual

iw-install:
	${INSTALL_DIR} ${IDIR_IW}/usr/sbin
	${INSTALL_BIN} ${WRKINST}/usr/sbin/iw ${IDIR_IW}/usr/sbin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
