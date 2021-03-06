# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		xfsprogs
PKG_VERSION:=		4.3.0
PKG_RELEASE:=		1
PKG_HASH:=		3e570ad51153e4be3792f42b2c805ddbd46b55d166eba3102ec87d5006d4cb5c
PKG_DESCR:=		utilities for xfs filesystems
PKG_SECTION:=		sys/fs
PKG_BUILDDEP:=		e2fsprogs ncurses
PKG_DEPENDS:=		libuuid libncurses
PKG_NEEDS:=		threads rt
PKG_URL:=		http://oss.sgi.com/projects/xfs
PKG_SITES:=		ftp://oss.sgi.com/projects/xfs/cmd_tars/ \
			ftp://oss.sgi.com/projects/xfs/previous/cmd_tars/

PKG_NOPARALLEL:=	1
DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,XFSPROGS,xfsprogs,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

INSTALL_STYLE:=		manual
TARGET_LDFLAGS+=	-lrt
CONFIGURE_ARGS+=	--enable-gettext=no \
			--enable-blkid=no \
			--with-gnu-ld
CONFIGURE_ENV+=		DEBUG=" " OPTIMIZER=" " PLATFORM=linux \
			ac_cv_header_aio_h=yes ac_cv_lib_rt_lio_listio=yes
ALL_TARGET=

do-install:
	${INSTALL_DIR} ${IDIR_XFSPROGS}/usr/sbin
	${INSTALL_BIN} ${WRKBUILD}/mkfs/mkfs.xfs ${IDIR_XFSPROGS}/usr/sbin
	${INSTALL_BIN} ${WRKBUILD}/repair/xfs_repair ${IDIR_XFSPROGS}/usr/sbin
	${INSTALL_BIN} ${WRKBUILD}/growfs/xfs_growfs ${IDIR_XFSPROGS}/usr/sbin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
