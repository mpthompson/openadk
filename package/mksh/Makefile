# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		mksh
PKG_VERSION:=		52c
PKG_RELEASE:=		1
PKG_HASH:=		c6341acea725103f782c14e994d6e12dabaee69e60fe1bc78603a41258d43ba6
PKG_DESCR:=		mirbsd korn shell
PKG_SECTION:=		base/shells
PKG_NEEDS:=		mmu
PKG_URL:=		http://www.mirbsd.org/mksh.htm
PKG_SITES:=		$(MASTER_SITE_MIRBSD:distfiles/=dist/mir/mksh/)

PKG_DFLT_MKSH:=		y if !ADK_APPLIANCE_TOOLCHAIN

PKG_SUBPKGS:=		MKSH MKSH_TEST
PKGSD_MKSH_TEST:=	install testsuite
PKGSC_MKSH_TEST:=	base/tests
PKGSS_MKSH_TEST:=	perl ed

DISTFILES:=		$(PKG_NAME)-R$(PKG_VERSION).tgz
WRKDIST=		$(WRKDIR)/$(PKG_NAME)

include $(ADK_TOPDIR)/mk/host.mk
include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call HOST_template,MKSH,mksh,$(PKG_VERSION)-$(PKG_RELEASE)))
$(eval $(call PKG_template,MKSH,mksh,$(PKG_VERSION)-$(PKG_RELEASE),,$(PKG_DESCR),$(PKG_SECTION)))
$(eval $(call PKG_template,MKSH_TEST,mksh-test,$(PKG_VERSION)-$(PKG_RELEASE),,$(PKGSD_MKSH_TEST),$(PKGSC_MKSH_TEST)))

HOST_STYLE:=		manual
CONFIG_STYLE:=		manual
BUILD_STYLE:=		manual
INSTALL_STYLE:=		manual

host-build:
	cd $(WRKBUILD) && $(BASH) $(WRKSRC)/Build.sh -Q -r -c lto

mksh-hostinstall:
	$(INSTALL_DIR) $(STAGING_HOST_DIR)/usr/bin
	$(INSTALL_BIN) $(WRKBUILD)/mksh \
	    $(STAGING_HOST_DIR)/usr/bin

do-build:
	cd $(WRKBUILD) && CC='$(TARGET_CC)' CFLAGS='$(TARGET_CFLAGS)' \
	    CPPFLAGS='$(TARGET_CPPFLAGS)' LDFLAGS='$(TARGET_LDFLAGS)' \
	    HAVE_CAN_FSTACKPROTECTORALL=0 HAVE_CAN_FSTACKPROTECTORSTRONG=0 \
	    TARGET_OS=Linux $(BASH) $(WRKSRC)/Build.sh -Q -r -c lto

mksh-install:
	$(INSTALL_DIR) $(IDIR_MKSH)/root
	$(CP) $(WRKSRC)/dot.mkshrc $(IDIR_MKSH)/root/.mkshrc
	$(INSTALL_DIR) $(IDIR_MKSH)/bin
	$(INSTALL_BIN) $(WRKBUILD)/mksh $(IDIR_MKSH)/bin

mksh-test-install:
	$(INSTALL_DIR) $(IDIR_MKSH_TEST)/opt/mksh
	$(CP) $(WRKBUILD)/* $(IDIR_MKSH_TEST)/opt/mksh
	find $(IDIR_MKSH_TEST)/opt/mksh -name \*.o -delete
	$(INSTALL_BIN) ./files/test.sh $(IDIR_MKSH_TEST)/opt/mksh

include $(ADK_TOPDIR)/mk/host-bottom.mk
include $(ADK_TOPDIR)/mk/pkg-bottom.mk
