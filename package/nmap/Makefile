# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		nmap
PKG_VERSION:=		7.12
PKG_RELEASE:=		1
PKG_HASH:=		63df082a87c95a189865d37304357405160fc6333addcf5b84204c95e0539b04
PKG_DESCR:=		utility for network exploration or security auditing
PKG_SECTION:=		net/security
PKG_DEPENDS:=		libdnet libpcap libpcre
PKG_BUILDDEP:=		libdnet libpcap pcre
PKG_NEEDS:=		c++
PKG_URL:=		http://nmap.org/
PKG_SITES:=		http://download.insecure.org/nmap/dist/

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.bz2

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,NMAP,nmap,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

TARGET_CPPFLAGS+=	-DNOLUA
TARGET_LDFLAGS+=	-lpthread
CONFIGURE_ENV+=		ac_cv_dnet_bsd_bpf=no
CONFIGURE_ARGS+=	--without-openssl \
			--without-zenmap \
			--without-ndiff \
			--without-liblua \
			--with-libpcap="${STAGING_TARGET_DIR}/usr" \
			--with-libpcre="${STAGING_TARGET_DIR}/usr"
XAKE_FLAGS+=		GCC_HONOUR_COPTS=s

nmap-install:
	${INSTALL_DIR} ${IDIR_NMAP}/usr/share/nmap
	${INSTALL_DIR} ${IDIR_NMAP}/usr/bin
	for file in mac-prefixes os-db protocols rpc service-probes services; do \
		${CP} ${WRKINST}/usr/share/nmap/nmap-$$file ${IDIR_NMAP}/usr/share/nmap; \
	done
	${INSTALL_BIN} ${WRKINST}/usr/bin/nmap ${IDIR_NMAP}/usr/bin/

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
