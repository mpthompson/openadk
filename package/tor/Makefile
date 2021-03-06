# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		tor
PKG_VERSION:=		0.2.7.6
PKG_RELEASE:=		2
PKG_HASH:=		493a8679f904503048114aca6467faef56861206bab8283d858f37141d95105d
PKG_DESCR:=		anonymous internet communication system
PKG_SECTION:=		net/proxy
PKG_DEPENDS:=		libevent zlib
PKG_BUILDDEP:=		libevent zlib
PKG_NEEDS:=		threads
PKG_URL:=		https://www.torproject.org/
PKG_SITES:=		https://www.torproject.org/dist/

PKG_CHOICES_TOR:=	WITH_LIBRESSL WITH_OPENSSL
PKGCD_WITH_LIBRESSL:=	use libressl for crypto
PKGCB_WITH_LIBRESSL:=	libressl
PKGCS_WITH_LIBRESSL:=	libressl ca-certificates
PKGCD_WITH_OPENSSL:=	use openssl for crypto
PKGCB_WITH_OPENSSL:=	openssl
PKGCS_WITH_OPENSSL:=	libopenssl ca-certificates

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,TOR,tor,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

AUTOTOOL_STYLE:=	autoreconf
# -DNDEBUG not supported
TARGET_CPPFLAGS:=
CONFIGURE_ENV+=		ac_cv_libevent_normal=yes \
			ac_cv_libevent_linker_option="" \
			ac_cv_libevent_dir="${STAGING_TARGET_DIR}/usr" \
			ac_cv_openssldir="${STAGING_TARGET_DIR}/usr" \
			ac_cv_openssl_linker_option="" \
			tor_cv_time_t_signed=yes \
			tor_cv_null_is_zero=yes \
			tor_cv_unaligned_ok=yes

CONFIGURE_ARGS+=	--disable-tool-name-check

ifeq ($(ADK_TARGET_USE_SSP),y)
CONFIGURE_ARGS+=	--enable-gcc-hardening
else
CONFIGURE_ARGS+=	--disable-gcc-hardening
endif

tor-install:
	${INSTALL_DIR} ${IDIR_TOR}/usr/bin ${IDIR_TOR}/etc/tor
	${INSTALL_DATA} ./files/torrc ${IDIR_TOR}/etc/tor/
	${CP} ${WRKINST}/usr/bin/tor ${IDIR_TOR}/usr/bin/

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
