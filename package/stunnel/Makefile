# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		stunnel
PKG_VERSION:=		5.31
PKG_RELEASE:=		1
PKG_HASH:=		a746b71ab3dc6c23eacb0daf7342467870e43ac933430905eb1b1d050bbae0b7
PKG_DESCR:=		encryption wrapper
PKG_SECTION:=		net/security
PKG_URL:=		https://www.stunnel.org
PKG_SITES:=		https://www.stunnel.org/downloads/

PKG_CHOICES_STUNNEL:=	WITH_OPENSSL
PKGCD_WITH_LIBRESSL:=	use libressl for crypto
PKGCB_WITH_LIBRESSL:=	libressl
PKGCS_WITH_LIBRESSL:=	libressl ca-certificates
PKGCD_WITH_OPENSSL:=	use openssl for crypto
PKGCB_WITH_OPENSSL:=	openssl
PKGCS_WITH_OPENSSL:=	libopenssl ca-certificates

DISTFILES:=             ${PKG_NAME}-${PKG_VERSION}.tar.gz

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,STUNNEL,stunnel,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

AUTOTOOL_STYLE:=	autoreconf
CONFIGURE_ARGS+=	--with-ssl=${STAGING_TARGET_DIR}/usr \
			--disable-systemd \
			--disable-libwrap

stunnel-install:
	$(INSTALL_DIR) $(IDIR_STUNNEL)/usr/bin
	$(INSTALL_BIN) $(WRKINST)/usr/bin/stunnel \
		$(IDIR_STUNNEL)/usr/bin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
