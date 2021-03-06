# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		freeswitch
PKG_VERSION:=		1.6.9
PKG_RELEASE:=		1
PKG_HASH:=		aa5f191113be2bd44cb4f2108da3dcc37be3234c6b733896fbff97526ac66451
PKG_DESCR:=		cross-platform telephony platform
PKG_SECTION:=		net/voip
PKG_DEPENDS:=		libpcre libcurl zlib libjpeg-turbo libsqlite
PKG_BUILDDEP:=		util-linux zlib libjpeg-turbo sqlite curl pcre
PKG_BUILDDEP+=		speex
PKG_URL:=		http://www.freeswitch.org/
PKG_SITES:=		http://files.freeswitch.org/freeswitch-releases/

PKG_CHOICES_FREESWITCH:=WITH_LIBRESSL WITH_OPENSSL
PKGCD_WITH_LIBRESSL:=	use libressl for crypto
PKGCB_WITH_LIBRESSL:=	libressl
PKGCS_WITH_LIBRESSL:=	libressl
PKGCD_WITH_OPENSSL:=	use openssl for crypto
PKGCB_WITH_OPENSSL:=	openssl
PKGCS_WITH_OPENSSL:=	libopenssl


include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,FREESWITCH,freeswitch,$(PKG_VERSION)-$(PKG_RELEASE),$(PKG_DEPENDS),$(PKG_DESCR),$(PKG_SECTION)))

XAKE_FLAGS+=		GCC_HONOUR_COPTS=s
CONFIGURE_ARGS+=	--disable-core-libedit-support \
			--disable-libvpx
CONFIGURE_ENV+=		ac_cv_file__dev_ptmx=yes \
			ac_cv_file__dev_zero=yes \
			ac_cv_file__dev_urandom=yes \
			ac_cv_sizeof_ssize_t=4 \
		 	ac_cv_func_realloc_0_nonnull=yes \
		       	ac_cv_func_malloc_0_nonnull=yes \
			ac_cv_gcc_supports_w_no_unused_result=no \
			apr_cv_tcp_nodelay_with_cork=yes \
			ac_cv_file_dbd_apr_dbd_mysql_c=no \
			ac_cv_func_setpgrp_void=yes

pre-configure:
	$(SED) "/applications\/mod_enum/d" $(WRKBUILD)/modules.conf
	$(SED) "/applications\/mod_fsv/d" $(WRKBUILD)/modules.conf
	$(SED) "/languages\/mod_lua/d" $(WRKBUILD)/modules.conf
	$(SED) "/codecs\/mod_opus/d" $(WRKBUILD)/modules.conf
	$(SED) "/codecs\/mod_vpx/d" $(WRKBUILD)/modules.conf
	$(SED) "/formats\/mod_sndfile/d" $(WRKBUILD)/modules.conf

freeswitch-install:
	$(INSTALL_DIR) $(IDIR_FREESWITCH)/usr/bin
	$(INSTALL_BIN) $(WRKINST)/usr/bin/freeswitch \
		$(IDIR_FREESWITCH)/usr/bin

include $(ADK_TOPDIR)/mk/pkg-bottom.mk
