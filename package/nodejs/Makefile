# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		nodejs
PKG_VERSION:=		6.1.0
PKG_RELEASE:=		1
PKG_HASH:=		9e67ef0b8611e16e6e311eccf0489a50fe76ceebeea3023ef4f51be647ae4bc3
PKG_DESCR:=		asynchronous event driven framework
PKG_SECTION:=		net/http
PKG_DEPENDS:=		zlib
PKG_BUILDDEP:=		python2-host zlib
PKG_NEEDS:=		threads rt c++
PKG_URL:=		https://nodejs.org/
PKG_SITES:=		https://nodejs.org/dist/v$(PKG_VERSION)/

DISTFILES:=             node-v$(PKG_VERSION).tar.gz
WRKDIST=		$(WRKDIR)/node-v$(PKG_VERSION)

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,NODEJS,nodejs,$(PKG_VERSION)-$(PKG_RELEASE),$(PKG_DEPENDS),$(PKG_DESCR),$(PKG_SECTION)))

CONFIG_STYLE:=		manual

do-configure:
		(cd $(WRKSRC); \
                PYTHON=$(STAGING_HOST_DIR)/usr/bin/python2 \
                $(STAGING_HOST_DIR)/usr/bin/python2 ./configure \
			--prefix=/usr \
                	--without-snapshot \
                	--without-dtrace \
                	--without-etw \
                	--shared-zlib \
		)

nodejs-install:
	$(INSTALL_DIR) $(IDIR_NODEJS)/usr/lib
	$(CP) $(WRKINST)/usr/lib/node_modules \
		$(IDIR_NODEJS)/usr/lib
	$(INSTALL_DIR) $(IDIR_NODEJS)/usr/bin
	$(INSTALL_BIN) $(WRKINST)/usr/bin/node \
		$(IDIR_NODEJS)/usr/bin

include $(ADK_TOPDIR)/mk/pkg-bottom.mk
