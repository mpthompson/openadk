# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		irssi
PKG_VERSION:=		0.8.18
PKG_RELEASE:=		1
PKG_HASH:=		c0a177f749757c2d171ebe49ab0f0dd9cf9374dea81ab01904d0549bcb057840
PKG_DESCR:=		irc text client
PKG_SECTION:=		app/chat
PKG_DEPENDS:=		glib libncurses
PKG_BUILDDEP:=		glib ncurses
PKG_URL:=		http://www.irssi.org/
PKG_SITES:=		https://github.com/irssi/irssi/releases/download/$(PKG_VERSION)/

PKG_CHOICES_IRSSI:=	WITHOUT_SSL WITH_LIBRESSL WITH_OPENSSL
PKGCD_WITHOUT_SSL:=	use no ssl
PKGCD_WITH_LIBRESSL:=	use libressl for crypto
PKGCB_WITH_LIBRESSL:=	libressl
PKGCS_WITH_LIBRESSL:=	libressl
PKGCD_WITH_OPENSSL:=	use openssl for crypto
PKGCB_WITH_OPENSSL:=	openssl
PKGCS_WITH_OPENSSL:=	libopenssl

PKG_FLAVOURS_IRSSI:=	WITH_IPV6
PKGFD_WITH_IPV6:=	enable ipv6 support

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,IRSSI,irssi,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

TARGET_LDFLAGS+=	-ltinfo
CONFIGURE_ARGS+=	--with-perl=no \
			--with-gnu-ld \
			--with-textui \
			--with-terminfo \
			--without-bot \
			--without-proxy

ifneq (${ADK_PACKAGE_IRSSI_WITH_IPV6},)
CONFIGURE_ARGS+=	--enable-ipv6
else
CONFIGURE_ARGS+=	--disable-ipv6
endif

ifeq (${ADK_PACKAGE_IRSSI_WITHOUT_SSL},y)
CONFIGURE_ARGS+=	--disable-ssl
else
CONFIGURE_ARGS+=	--enable-ssl
endif

irssi-install:
	${INSTALL_DIR} ${IDIR_IRSSI}/usr/bin
	${INSTALL_BIN} ${WRKINST}/usr/bin/irssi ${IDIR_IRSSI}/usr/bin/

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
