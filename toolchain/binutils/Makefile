# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk
include Makefile.inc
include ../rules.mk
include ${ADK_TOPDIR}/mk/buildhlp.mk

ifeq ($(ADK_TOOLCHAIN_WITH_SSP),y)
CONFOPTS+=		--enable-libssp
else
CONFOPTS+=		--disable-libssp
endif

ifeq ($(ADK_TOOLCHAIN_WITH_LTO),y)
CONFOPTS+=		--enable-lto --enable-plugins
else
CONFOPTS+=		--disable-lto --disable-plugins
endif

ifeq ($(ADK_TOOLCHAIN_WITH_GOLD),y)
CONFOPTS+=		--enable-gold=default
else
CONFOPTS+=		--disable-gold
endif

ifeq ($(ADK_TARGET_ARCH_X86_64)$(ADK_TARGET_CPU_CF),)
CONFOPTS+=		--disable-multilib
else
CONFOPTS+=		--enable-multilib
endif

ifeq (${ADK_MAKE_PARALLEL},y)
BINUTILS_MAKEOPTS+=	-j${ADK_MAKE_JOBS}
endif

ifeq (${ADK_STATIC_TOOLCHAIN},y)
BINUTILS_STATIC_MAKEOPTS+=LDFLAGS='$(HOST_STATIC_LLDFLAGS)'
endif

$(WRKBUILD)/.configured:
ifeq ($(ADK_TARGET_ARCH_XTENSA),y)
	tar xf $(ADK_TOPDIR)/target/xtensa/overlay/xtensa_$(ADK_TARGET_CPU_TYPE).tar \
		--strip-components=1 -C $(WRKSRC) binutils
endif
	(cd $(WRKBUILD); \
		$(WRKBUILD)/configure \
		--prefix=$(TOOLCHAIN_DIR)/usr \
		--target=$(GNU_TARGET_NAME) \
		--with-sysroot=$(STAGING_TARGET_DIR) \
		--disable-dependency-tracking \
		--disable-libtool-lock \
		--disable-nls \
		--disable-sim \
		--disable-gdb \
		--disable-werror \
		--disable-install-libiberty \
		${CONFOPTS} \
	);
	$(MAKE) ${BINUTILS_MAKEOPTS} -C $(WRKBUILD) configure-host
	touch $@

$(WRKBUILD)/.compiled: $(WRKBUILD)/.configured
	$(MAKE) ${BINUTILS_MAKEOPTS} ${BINUTILS_STATIC_MAKEOPTS} -C $(WRKBUILD) all
	touch $@

$(WRKBUILD)/.installed: $(WRKBUILD)/.compiled
	$(MAKE) -C $(WRKBUILD) install
ifeq ($(ADK_TARGET_ARCH_H8300),y)
	$(INSTALL_DIR) $(STAGING_TARGET_DIR)/usr/lib/ldscripts
	$(CP) $(WRKBUILD)/ld/ldscripts/* $(STAGING_TARGET_DIR)/usr/lib/ldscripts/
endif
ifeq ($(ADK_TARGET_USE_GOLD),y)
	(cd $(TOOLCHAIN_DIR)/usr/bin && \
		ln -sf $(GNU_TARGET_NAME)-ld.gold $(GNU_TARGET_NAME)-ld)
else
ifeq (ADK_TOOLCHAIN_BINUTILS_2_20_1),)
	(cd $(TOOLCHAIN_DIR)/usr/bin && \
		ln -sf $(GNU_TARGET_NAME)-ld.bfd $(GNU_TARGET_NAME)-ld)
endif
endif
	touch $@

include ${ADK_TOPDIR}/mk/toolchain.mk
