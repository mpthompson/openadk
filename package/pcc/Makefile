# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		pcc
PKG_VERSION:=		1.0.0
PKG_RELEASE:=		1
PKG_HASH:=		5802dbba46d6ea3f9badaa55b9044a0416bb410020c24a5c2a8a2eaaf41156cb
PKG_DESCR:=		portable c compiler
PKG_SECTION:=		dev/lang
PKG_DEPENDS:=		pcc-libs
PKG_URL:=		http://pcc.ludd.ltu.se/
PKG_SITES:=		http://pcc.ludd.ltu.se/ftp/pub/pcc-releases/
PKG_NOPARALLEL:=	1

PKG_CFLINE_PCC:=	depends on ADK_BROKEN

PKG_ARCH_DEPENDS:=	!arm !m68k !mips !ppc
DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tgz

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,PCC,pcc,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

# we cross-compile a native compiler for the target system
CONFIGURE_ARGS+=	--host=${GNU_TARGET_NAME} \
			--target=${GNU_TARGET_NAME} \
			--with-assembler=/usr/bin/as \
			--with-linker=/usr/bin/ld

ifeq ($(ADK_TARGET_LIB_GLIBC),y)
TARGET_CPPFLAGS+=	-DADK_FOR_GLIBC
endif
ifeq ($(ADK_TARGET_LIB_UCLIBC_NG),y)
TARGET_CPPFLAGS+=	-DADK_FOR_UCLIBC
endif

pcc-install:
	$(INSTALL_DIR) $(IDIR_PCC)
	cd ${WRKINST} && cp -r * ${IDIR_PCC}/

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
