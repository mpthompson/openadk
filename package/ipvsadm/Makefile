# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		ipvsadm
PKG_VERSION:=		1.26
PKG_RELEASE:=		2
PKG_HASH:=		6d6c46fecb1c532a892616b4445c73b71730e8790d5630f60269fd9cbee0eb2d
PKG_DESCR:=		ip virtual server admin utility
PKG_SECTION:=		net/misc
PKG_DEPENDS:=		libpopt
PKG_BUILDDEP:=		popt
PKG_URL:=		http://www.linuxvirtualserver.org/
PKG_SITES:=		http://www.linuxvirtualserver.org/software/kernel-2.6/
PKG_NOPARALLEL:=	1

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

include $(ADK_TOPDIR)/mk/package.mk

TARGET_CFLAGS+=		-I$(STAGING_TARGET_DIR)/usr/include/libnl3 -fPIC -DHAVE_NL=0
CONFIG_STYLE:=		manual
XAKE_FLAGS+=		HAVE_NL=0

$(eval $(call PKG_template,IPVSADM,ipvsadm,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

ipvsadm-install:
	$(INSTALL_DIR) $(IDIR_IPVSADM)/usr/sbin
	$(INSTALL_DIR) $(IDIR_IPVSADM)/usr/lib
	$(CP) $(WRKBUILD)/libipvs/libipvs.so \
		$(IDIR_IPVSADM)/usr/lib
	$(INSTALL_BIN) $(WRKINST)/sbin/ipvsadm \
		$(IDIR_IPVSADM)/usr/sbin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
