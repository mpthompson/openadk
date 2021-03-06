# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		file
PKG_VERSION:=		5.28
PKG_RELEASE:=		1
PKG_HASH:=		0ecb5e146b8655d1fa84159a847ee619fc102575205a0ff9c6cc60fc5ee2e012
PKG_DESCR:=		file type guesser
PKG_SECTION:=		sys/utils
PKG_BUILDDEP:=		file-host
PKG_DEPENDS:=		libmagic magic
PKG_URL:=		http://www.darwinsys.com/file
PKG_SITES:=		ftp://ftp.fu-berlin.de/unix/tools/file/ \
			ftp://ftp.astron.com/pub/file/
PKG_LIBNAME:=		libmagic
PKG_OPTS:=		dev

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

PKG_SUBPKGS:=		FILE LIBMAGIC MAGIC
PKGSD_LIBMAGIC:=	file type guesser library
PKGSC_LIBMAGIC:=	libs/misc
PKGSD_MAGIC:=		magic file
PKGSC_MAGIC:=		sys/misc

include ${ADK_TOPDIR}/mk/host.mk
include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call HOST_template,FILE,file,${PKG_VERSION}-${PKG_RELEASE}))
$(eval $(call PKG_template,FILE,${PKG_NAME},${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))
$(eval $(call PKG_template,LIBMAGIC,libmagic,${PKG_VERSION}-${PKG_RELEASE},${PKGSS_LIBMAGIC},${PKGSD_LIBMAGIC},${PKGSC_LIBMAGIC},${PKG_OPTS}))
$(eval $(call PKG_template,MAGIC,magic,${PKG_VERSION}-${PKG_RELEASE},${PKGSS_MAGIC},${PKGSD_MAGIC},${PKGSC_MAGIC}))

AUTOTOOL_STYLE:=	autoreconf

ifeq ($(ADK_TARGET_USE_STATIC_LIBS),y)
MAKE_FLAGS+=		LDFLAGS="$(TARGET_LDFLAGS) -all-static"
endif

HOST_CONFIGURE_ARGS+=	--enable-static \
			--disable-shared \
			--disable-warnings

file-install:
	${INSTALL_DIR} ${IDIR_FILE}/usr/bin
	${INSTALL_BIN} ${WRKINST}/usr/bin/file ${IDIR_FILE}/usr/bin

magic-install:
	${INSTALL_DIR} ${IDIR_LIBMAGIC}/usr/share/misc
	${INSTALL_DATA} ${WRKINST}/usr/share/misc/magic.mgc \
		${IDIR_LIBMAGIC}/usr/share/misc

libmagic-install:
	${INSTALL_DIR} ${IDIR_LIBMAGIC}/usr/lib
	${CP} ${WRKINST}/usr/lib/libmagic.so* ${IDIR_LIBMAGIC}/usr/lib

include ${ADK_TOPDIR}/mk/host-bottom.mk
include ${ADK_TOPDIR}/mk/pkg-bottom.mk
