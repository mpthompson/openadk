ifeq ($(ADK_KERNEL_VERSION_TOOLCHAIN),y)
KERNEL_VERSION:=	3.5.4
KERNEL_MOD_VERSION:=	$(KERNEL_VERSION)
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		95d5c7271ad448bc965bdb29339b6923
endif
ifeq ($(ADK_KERNEL_VERSION_3_5_4),y)
KERNEL_VERSION:=	3.5.4
KERNEL_MOD_VERSION:=	$(KERNEL_VERSION)
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		95d5c7271ad448bc965bdb29339b6923
endif
ifeq ($(ADK_KERNEL_VERSION_3_4_9),y)
KERNEL_VERSION:=	3.4.9
KERNEL_MOD_VERSION:=	$(KERNEL_VERSION)
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		f9cd4fe763396bf814f3a71de42fde9b
endif
