# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		bitlbee
PKG_VERSION:=		3.0.1
PKG_RELEASE:=		1
PKG_HASH:=		408a737b35db4b9c407e3db09b2d2e7b528836a68e2d783373254b78812bf608
PKG_DESCR:=		irc gateway to im chat networks
PKG_SECTION:=		app/chat
PKG_DEPENDS:=		glib
PKG_BUILDDEP:=		glib
PKG_URL:=		http://www.bitlbee.org/
PKG_SITES:=		http://get.bitlbee.org/src/

PKG_CHOICES_BITLBEE:=	WITH_LIBRESSL WITH_OPENSSL
PKGCD_WITH_LIBRESSL:=	use libressl for crypto
PKGCB_WITH_LIBRESSL:=	libressl
PKGCS_WITH_LIBRESSL:=	libressl ca-certificates
PKGCD_WITH_OPENSSL:=	use openssl for crypto
PKGCB_WITH_OPENSSL:=	openssl
PKGCS_WITH_OPENSSL:=	libopenssl ca-certificates

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,BITLBEE,bitlbee,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

CONFIG_STYLE:=		minimal
TARGET_CFLAGS+=		-fPIC
CONFIGURE_ARGS:=	--target=${GNU_TARGET_NAME} \
			--prefix=/usr \
			--bindir=/usr/sbin \
			--etcdir=/etc/bitlbee \
			--datadir=/usr/share/bitlbee \
			--config=/var/lib/bitlbee \
			--arch=Linux \
			--cpu="${ADK_TARGET_ARCH}" \
			--debug=0 \
			--strip=0 \
			--ipv6=1 \
			--ssl=openssl
INSTALL_TARGET=		install-etc install-bin

post-configure:
	@echo 'CFLAGS+="-I${STAGING_TARGET_DIR}/usr/include/iconv"' >> \
		${WRKBUILD}/Makefile.settings
	@echo 'LFLAGS+=${TARGET_LDFLAGS}' >> \
		${WRKBUILD}/Makefile.settings

bitlbee-install:
	${INSTALL_DIR} ${IDIR_BITLBEE}/etc/bitlbee ${IDIR_BITLBEE}/usr/sbin
	${INSTALL_DATA} ${WRKINST}/etc/bitlbee/* ${IDIR_BITLBEE}/etc/bitlbee
	${INSTALL_BIN} ${WRKINST}/usr/sbin/bitlbee ${IDIR_BITLBEE}/usr/sbin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
