# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		rsyslog
PKG_VERSION:=		8.10.0
PKG_RELEASE:=		1
PKG_HASH:=		b92df3f367108219e2fffccd463bf49d75cb8ab3ceaa52e9789f85eace066912
PKG_DESCR:=		syslog daemon
PKG_SECTION:=		sys/misc
PKG_BUILDDEP:=		libestr liblogging json-c util-linux zlib ncurses
PKG_DEPENDS:=		libestr liblogging json-c libuuid zlib libncurses
PKG_NEEDS:=		threads rt
PKG_URL:=		http://www.rsyslog.com/
PKG_SITES:=		http://www.rsyslog.com/files/download/rsyslog/

DISTFILES:=             ${PKG_NAME}-${PKG_VERSION}.tar.gz

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,RSYSLOG,rsyslog,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

CONFIGURE_ENV+=		ac_cv_func_malloc_0_nonnull=yes \
			ac_cv_func_realloc_0_nonnull=yes

rsyslog-install:
	$(INSTALL_DIR) $(IDIR_RSYSLOG)/etc
	$(CP) ./files/rsyslog.conf $(IDIR_RSYSLOG)/etc
	$(INSTALL_DIR) $(IDIR_RSYSLOG)/usr/lib/rsyslog
	$(CP) $(WRKINST)/usr/lib/rsyslog/*.so \
		$(IDIR_RSYSLOG)/usr/lib/rsyslog
	$(INSTALL_DIR) $(IDIR_RSYSLOG)/usr/sbin
	$(INSTALL_BIN) $(WRKINST)/usr/sbin/rsyslogd \
		$(IDIR_RSYSLOG)/usr/sbin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
