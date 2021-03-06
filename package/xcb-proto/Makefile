# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		xcb-proto
PKG_VERSION:=		1.10
PKG_RELEASE:=		1
PKG_DESCR:=		xml-xcb protocol descriptions
PKG_SECTION:=		dev/header
PKG_HASH:=		d0e6a2c8aed8af430edd011bb139368480d556b0829adcf1e1ca5708d1fc04b9
HOST_BUILDDEP:=		python2-host
PKG_SITES:=		http://xcb.freedesktop.org/dist/
PKG_OPTS:=		dev devonly

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

PKG_SUBPKGS:=		XCB_PROTO XCB_PYTHON
PKGSC_XCB_PYTHON:=	x11/misc

include $(ADK_TOPDIR)/mk/host.mk
include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call HOST_template,XCB_PROTO,xcb-proto,$(PKG_VERSION)-${PKG_RELEASE}))
$(eval $(call PKG_template,XCB_PROTO,xcb-proto,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION},${PKG_OPTS}))
$(eval $(call PKG_template,XCB_PYTHON,xcb-python,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKGSC_XCB_PYTHON}))

include $(ADK_TOPDIR)/mk/python.mk

HOST_STYLE:=		auto
CONFIGURE_ENV+=		PYTHON=$(PYTHON)

# pkg-config variables are not fixed up with sysroot
hostpost-install:
	$(SED) 's|^\(xcbincludedir=\)|\1$(STAGING_HOST_DIR)|' \
		$(STAGING_HOST_DIR)/usr/lib/pkgconfig/xcb-proto.pc

post-build:
	${INSTALL_DIR} ${STAGING_TARGET_DIR}/usr/share/xcb
	${CP} ${WRKBUILD}/src/*.xml ${STAGING_TARGET_DIR}/usr/share/xcb
	$(SED) 's|^\(xcbincludedir=\)|\1$(STAGING_TARGET_DIR)|' \
		$(WRKBUILD)/xcb-proto.pc

xcb-python-install:
	$(INSTALL_DIR) ${STAGING_TARGET_DIR}/usr/lib/python${PYTHON_VERSION}/site-packages/xcbgen
	${CP} ${WRKINST}/usr/lib/python${PYTHON_VERSION}/site-packages/xcbgen/*.py \
		${STAGING_TARGET_DIR}/usr/lib/python${PYTHON_VERSION}/site-packages/xcbgen
	${INSTALL_DIR} ${IDIR_XCB_PYTHON}/usr/lib/python${PYTHON_VERSION}/site-packages/xcbgen
	${CP} ${WRKINST}/usr/lib/python${PYTHON_VERSION}/site-packages/xcbgen/*.py \
		${IDIR_XCB_PYTHON}/usr/lib/python${PYTHON_VERSION}/site-packages/xcbgen

include ${ADK_TOPDIR}/mk/host-bottom.mk
include ${ADK_TOPDIR}/mk/pkg-bottom.mk
