# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		madplay
PKG_VERSION:=		0.15.2b
PKG_RELEASE:=		2
PKG_HASH:=		5a79c7516ff7560dffc6a14399a389432bc619c905b13d3b73da22fa65acede0
PKG_DESCR:=		mpeg audio player in fixed point
PKG_SECTION:=		mm/audio
PKG_DEPENDS:=		libid3tag libmad alsa-lib
PKG_BUILDDEP:=		libid3tag libmad alsa-lib
PKG_URL:=		http://www.underbit.com/products/mad
PKG_SITES:=		${MASTER_SITE_SOURCEFORGE:=mad/}  \
			ftp://ftp.mars.org/pub/mpeg/

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,MADPLAY,madplay,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

TARGET_CPPFLAGS+=	-D_GNU_SOURCE -D_POSIX_SOURCE
CONFIGURE_ENV+=		BUILD_CC="${TARGET_CC}" HOSTCC=${CC_FOR_BUILD} \
			LIBS="-lz" \
			ac_cv_linux_vers=2 \
			td_cv_buggygetaddrinfo="no"
CONFIGURE_ARGS+=	--disable-debugging \
			--disable-profiling \
			--disable-experimental \
			--without-libiconv-prefix \
			--without-libintl-prefix \
			--without-esd \
			--with-alsa

madplay-install:
	${INSTALL_DIR} ${IDIR_MADPLAY}/usr/bin
	${INSTALL_BIN} ${WRKINST}/usr/bin/madplay ${IDIR_MADPLAY}/usr/bin/

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
