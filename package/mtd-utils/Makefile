# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		mtd-utils
PKG_VERSION:=		1.5.2
PKG_RELEASE:=		1
PKG_HASH:=		e76c379fdd77818686a221b9642b12540e6060285aa58d6f7d016774c24d5503
PKG_DESCR:=		flash filesystem utilities
PKG_SECTION:=		sys/fs
PKG_BUILDDEP:=		zlib
HOST_BUILDDEP:=		liblzo-host
PKG_URL:=		http://www.linux-mtd.infradead.org
PKG_SITES:=		http://git.infradead.org/mtd-utils.git/snapshot/

DISTFILES:=             ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f.tar.gz
WRKDIST=		${WRKDIR}/mtd-utils-ca39eb1

PKG_SUBPKGS:=		MTD_UTILS NANDWRITE NANDDUMP NANDTEST FLASH_ERASE FLASH_OTP_INFO FLASH_OTP_DUMP FLASH_LOCK
PKGSD_NANDWRITE:=	mtd-utils nandwrite utility
PKGSD_NANDDUMP:=	mtd-utils nanddump utility
PKGSD_NANDTEST:=	mtd-utils nandtest utility
PKGSD_FLASH_ERASE:=	mtd-utils flash_erase utility
PKGSD_FLASH_OTP_INFO:=	mtd-utils flash_otp_info utility
PKGSD_FLASH_OTP_DUMP:=	mtd-utils flash_otp_dump utility
PKGSD_FLASH_LOCK:=	mtd-utils flash_lock/flash_unlock utilities

PKG_FLAVOURS_MTD_UTILS:=WITH_LZO WITH_UBIFS
PKGFD_WITH_LZO:=	enable lzo support
PKGFS_WITH_LZO:=	liblzo
PKGFB_WITH_LZO:=	liblzo
PKGFD_WITH_UBIFS:=	enable ubifs support
PKGFS_WITH_UBIFS:=	libuuid
PKGFB_WITH_UBIFS:=	util-linux

include $(ADK_TOPDIR)/mk/host.mk
include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call HOST_template,MTD_UTILS,mtd-utils,$(PKG_VERSION)-${PKG_RELEASE}))
$(eval $(call PKG_template,MTD_UTILS,$(PKG_NAME),$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))
$(eval $(call PKG_template,NANDWRITE,nandwrite,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_NANDWRITE},${PKG_SECTION}))
$(eval $(call PKG_template,NANDDUMP,nanddump,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_NANDDUMP},${PKG_SECTION}))
$(eval $(call PKG_template,NANDTEST,nandtest,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_NANDTEST},${PKG_SECTION}))
$(eval $(call PKG_template,FLASH_ERASE,flash-erase,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_FLASH_ERASE},${PKG_SECTION}))
$(eval $(call PKG_template,FLASH_OTP_INFO,flash-otp-info,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_FLASH_OTP_INFO},${PKG_SECTION}))
$(eval $(call PKG_template,FLASH_OTP_DUMP,flash-otp-dump,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_FLASH_OTP_DUMP},${PKG_SECTION}))
$(eval $(call PKG_template,FLASH_LOCK,flash-lock,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_FLASH_LOCK},${PKG_SECTION}))

HOST_STYLE:=		manual
HOST_CPPFLAGS+=		-DWITHOUT_XATTR=1 -I./include

host-build:
	(cd ${WRKBUILD} && env ${HOST_MAKE_ENV} ${MAKE} -f ${MAKE_FILE} \
		${HOST_MAKE_FLAGS} ${HOST_ALL_TARGET})

mtd-utils-hostinstall:
	${INSTALL_DIR} ${STAGING_HOST_DIR}/usr/bin
	${INSTALL_BIN} ${WRKBUILD}/mkfs.jffs2 \
		${STAGING_HOST_DIR}/usr/bin

CONFIG_STYLE:=		manual
XAKE_FLAGS+=		WITHOUT_XATTR=1
ifneq (${ADK_PACKAGE_MTD_UTILS_WITH_LZO},y)
XAKE_FLAGS+=		WITHOUT_LZO=1
endif
ifneq (${ADK_PACKAGE_MTD_UTILS_WITH_UBIFS},y)
XAKE_FLAGS+=		WITHOUT_UBI=1
endif
XAKE_FLAGS+=		BUILDDIR="${WRKDIST}"

mtd-utils-install:
	$(INSTALL_DIR) $(IDIR_MTD_UTILS)/usr/bin
	$(INSTALL_BIN) $(WRKINST)/usr/sbin/{doc,flash_otp_,ftl_,nftl,rfd}* \
		${WRKINST}/usr/sbin/{flashcp,jffs2dump,mkfs.jffs2,mtd_debug,recv_image,serve_image,sumtool} \
		$(IDIR_MTD_UTILS)/usr/bin

nandwrite-install:
	$(INSTALL_DIR) $(IDIR_NANDWRITE)/usr/sbin
	${INSTALL_BIN} ${WRKINST}/usr/sbin/nandwrite \
		${IDIR_NANDWRITE}/usr/sbin

nanddump-install:
	$(INSTALL_DIR) $(IDIR_NANDDUMP)/usr/sbin
	${INSTALL_BIN} ${WRKINST}/usr/sbin/nanddump \
		${IDIR_NANDDUMP}/usr/sbin

nandtest-install:
	$(INSTALL_DIR) $(IDIR_NANDTEST)/usr/sbin
	${INSTALL_BIN} ${WRKINST}/usr/sbin/nandtest \
		${IDIR_NANDTEST}/usr/sbin

flash-erase-install:
	$(INSTALL_DIR) $(IDIR_FLASH_ERASE)/usr/sbin
	${INSTALL_BIN} ${WRKINST}/usr/sbin/flash_erase \
		${IDIR_FLASH_ERASE}/usr/sbin

flash-otp-info-install:
	$(INSTALL_DIR) $(IDIR_FLASH_OTP_INFO)/usr/sbin
	${INSTALL_BIN} ${WRKINST}/usr/sbin/flash_otp_info \
		${IDIR_FLASH_OTP_INFO}/usr/sbin

flash-otp-dump-install:
	$(INSTALL_DIR) $(IDIR_FLASH_OTP_DUMP)/usr/sbin
	${INSTALL_BIN} ${WRKINST}/usr/sbin/flash_otp_dump \
		${IDIR_FLASH_OTP_DUMP}/usr/sbin

flash-lock-install:
	$(INSTALL_DIR) $(IDIR_FLASH_LOCK)/usr/sbin
	${INSTALL_BIN} ${WRKINST}/usr/sbin/flash_{lock,unlock} \
		${IDIR_FLASH_LOCK}/usr/sbin

include ${ADK_TOPDIR}/mk/host-bottom.mk
include ${ADK_TOPDIR}/mk/pkg-bottom.mk
