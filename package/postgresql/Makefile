# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		postgresql
PKG_VERSION:=		9.5.3
PKG_RELEASE:=		1
PKG_HASH:=		1f070a8e80ce749e687d2162e4a27107e2cc1703a471540e08111bbfb5853f9e
PKG_DESCR:=		postgresql database library
PKG_SECTION:=		libs/db
PKG_URL:=		http://www.postgresql.org/
PKG_SITES:=		http://ftp.postgresql.org/pub/source/v$(PKG_VERSION)/
PKG_LIBNAME:=		libpq
PKG_OPTS:=		dev

DISTFILES:=             $(PKG_NAME)-$(PKG_VERSION).tar.gz

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,LIBPQ,libpq,$(PKG_VERSION)-$(PKG_RELEASE),$(PKG_DEPENDS),$(PKG_DESCR),$(PKG_SECTION),$(PKG_OPTS)))

CONFIGURE_ARGS+=	--disable-integer-datetimes \
			--without-openssl \
			--without-pam \
			--without-perl \
			--without-python \
			--without-readline \
			--without-zlib \
			--without-bonjour \
			--without-tcl \
			--with-system-tzdata=$(STAGING_TARGET_DIR)

libpq-install:
	$(INSTALL_DIR) $(IDIR_LIBPQ)/usr/lib
	$(CP) $(WRKINST)/usr/lib/libpq.so* $(IDIR_LIBPQ)/usr/lib

post-install:
	PATH='$(HOST_PATH)' sed -e "s#@@STAGING_TARGET_DIR@@#$(STAGING_TARGET_DIR)#" \
		./files/pg_config > $(STAGING_HOST_DIR)/usr/bin/pg_config
	-rm $(STAGING_TARGET_DIR)/usr/bin/pg_config

include $(ADK_TOPDIR)/mk/pkg-bottom.mk
