# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		u-boot
PKG_VERSION:=		2016.05
PKG_RELEASE:=		1
PKG_HASH:=		87d02275615aaf0cd007b54cbe9fbadceef2bee7c79e6c323ea1ae8956dcb171
PKG_DESCR:=		portable bootloader
PKG_SECTION:=		base/boot
HOST_BUILDDEP:=		libressl-host device-tree-compiler-host
PKG_BUILDDEP:=		u-boot-host
PKG_URL:=		http://www.denx.de/wiki/U-Boot	
PKG_SITES:=		ftp://ftp.denx.de/pub/u-boot/

DISTFILES:=		$(PKG_NAME)-$(PKG_VERSION).tar.bz2

PKG_SYSTEM_DEPENDS:=	raspberry-pi raspberry-pi2 atmel-ngw100 banana-pro solidrun-imx6

include $(ADK_TOPDIR)/mk/host.mk
include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call HOST_template,U_BOOT,u-boot,$(PKG_VERSION)-$(PKG_RELEASE)))
$(eval $(call PKG_template,U_BOOT,u-boot,$(PKG_VERSION)-$(PKG_RELEASE),$(PKG_DEPENDS),$(PKG_DESCR),$(PKG_SECTION)))

UBOOT:=			u-boot.bin
ifeq ($(ADK_TARGET_SYSTEM_SOLIDRUN_IMX6),y)
CONFIG:=		mx6cuboxi_defconfig
UBOOT:=			u-boot.img
endif
ifeq ($(ADK_TARGET_SYSTEM_RASPBERRY_PI),y)
CONFIG:=		rpi_defconfig
endif
ifeq ($(ADK_TARGET_SYSTEM_RASPBERRY_PI2),y)
CONFIG:=		rpi_defconfig
endif
ifeq ($(ADK_TARGET_SYSTEM_ATMEL_NGW100),y)
CONFIG:=		atngw100_defconfig
endif
ifeq ($(ADK_TARGET_SYSTEM_BANANA_PRO),y)
CONFIG:=		Bananapro_defconfig
UBOOT:=			u-boot-sunxi-with-spl.bin
endif

HOST_MAKE_FLAGS+=	HOSTCFLAGS="$(HOST_CPPFLAGS) $(HOST_CFLAGS)" \
			HOSTLDFLAGS="$(HOST_LDFLAGS) -ldl"
HOST_STYLE:=		manual
CONFIG_STYLE:=		manual
BUILD_STYLE:=		manual
INSTALL_STYLE:=		manual

host-build:
	(cd $(WRKBUILD) && env $(HOST_MAKE_ENV) $(MAKE) -f $(MAKE_FILE) \
		$(HOST_MAKE_FLAGS) sandbox_defconfig )
	(cd $(WRKBUILD) && env $(HOST_MAKE_ENV) $(MAKE) -f $(MAKE_FILE) \
		$(HOST_MAKE_FLAGS) tools $(MAKE_TRACE) )

u-boot-hostinstall:
	$(INSTALL_BIN) $(WRKBUILD)/tools/mk{,env}image \
		$(STAGING_HOST_DIR)/usr/bin

do-configure:
	(cd $(WRKBUILD) && $(MAKE) $(CONFIG))

do-build:
	(cd $(WRKBUILD) && env \
		PATH='$(HOST_PATH)' \
		CROSS_COMPILE='$(TARGET_CROSS)' \
		GCC_HONOUR_COPTS=s $(MAKE))
	(cd $(WRKBUILD) && env CROSS_COMPILE='$(TARGET_CROSS)' \
		GCC_HONOUR_COPTS=s $(MAKE) env)

u-boot-install:
	$(CP) $(WRKBUILD)/$(UBOOT) $(FW_DIR)
	$(INSTALL_DIR) $(IDIR_U_BOOT)/etc
	$(CP) ./files/fw_env.config $(IDIR_U_BOOT)/etc
	$(INSTALL_DIR) $(IDIR_U_BOOT)/usr/bin
	$(INSTALL_BIN) $(WRKBUILD)/tools/env/fw_printenv \
		$(IDIR_U_BOOT)/usr/bin
	(cd $(IDIR_U_BOOT)/usr/bin && ln -sf fw_printenv fw_setenv)
	$(INSTALL_BIN) ./files/uboot_print_env $(IDIR_U_BOOT)/usr/bin
	$(INSTALL_BIN) ./files/uboot_set_env $(IDIR_U_BOOT)/usr/bin
ifeq ($(ADK_TARGET_SYSTEM_BANANA_PRO),y)
	$(INSTALL_BIN) ./files/boot.script.bpi $(FW_DIR)
endif
ifeq ($(ADK_TARGET_SYSTEM_SOLIDRUN_IMX6),y)
	$(INSTALL_BIN) $(WRKBUILD)/SPL $(FW_DIR)
	$(INSTALL_BIN) ./files/boot.script.imx6 $(FW_DIR)
endif

include $(ADK_TOPDIR)/mk/host-bottom.mk
include $(ADK_TOPDIR)/mk/pkg-bottom.mk
