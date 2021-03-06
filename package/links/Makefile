# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		links
PKG_VERSION:=		2.12
PKG_RELEASE:=		1
PKG_HASH:=		2e3da6193de9d6ee71bc4beab17169ecc58d7cbf2e20192a3f518ed9f7f22e33
PKG_DESCR:=		web browser with graphic support
PKG_SECTION:=		app/browser
PKG_DEPENDS:=		libpng libjpeg-turbo libtiff gpm
PKG_BUILDDEP:=		libpng libjpeg-turbo gpm
PKG_URL:=		http://links.twibright.com/
PKG_SITES:=		http://links.twibright.com/download/

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

PKG_CHOICES_LINKS:=	WITHOUT_SSL WITH_LIBRESSL WITH_OPENSSL
PKGCD_WITHOUT_SSL:=	use no ssl
PKGCD_WITH_LIBRESSL:=	use libressl for crypto
PKGCB_WITH_LIBRESSL:=	libressl
PKGCS_WITH_LIBRESSL:=	libressl
PKGCD_WITH_OPENSSL:=	use openssl for crypto
PKGCB_WITH_OPENSSL:=	openssl
PKGCS_WITH_OPENSSL:=	libopenssl

PKG_FLAVOURS_LINKS:=	WITH_DIRECTFB
PKGFD_WITH_DIRECTFB:=	enable DirectFB video output support
PKGFS_WITH_DIRECTFB:=	directfb
PKGFB_WITH_DIRECTFB:=	DirectFB

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,LINKS,links,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

CONFIGURE_ARGS+=	--enable-graphics \
			--with-fb \
			--without-svgalib \
			--without-libtiff \
			--without-x \
			--without-pmshell \
			--without-atheos

ifeq (${ADK_PACKAGE_LINKS_WITHOUT_SSL},y)
CONFIGURE_ARGS+=	--without-ssl
else
CONFIGURE_ARGS+=	--with-ssl
endif

ifeq (${ADK_PACKAGE_LINKS_WITH_DIRECTFB},y)
CONFIGURE_ARGS+=	--with-directfb
else
CONFIGURE_ARGS+=	--without-directfb
endif

links-install:
	${INSTALL_DIR} ${IDIR_LINKS}/usr/bin
	${CP} ${WRKINST}/usr/bin/* ${IDIR_LINKS}/usr/bin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
