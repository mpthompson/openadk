ifeq ($(ADK_KERNEL_VERSION_TOOLCHAIN),y)
KERNEL_VERSION:=	3.12.13
KERNEL_MOD_VERSION:=	$(KERNEL_VERSION)
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		345f5883cfb906dac4aef87e303d3a2d
endif
ifeq ($(ADK_KERNEL_VERSION_3_13_6),y)
KERNEL_VERSION:=	3.13.6
KERNEL_MOD_VERSION:=	$(KERNEL_VERSION)
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		445aa27da818617409982f42902a6e41
endif
ifeq ($(ADK_KERNEL_VERSION_3_12_13),y)
KERNEL_VERSION:=	3.12.13
KERNEL_MOD_VERSION:=	$(KERNEL_VERSION)
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		345f5883cfb906dac4aef87e303d3a2d
endif
ifeq ($(ADK_KERNEL_VERSION_3_11_10),y)
KERNEL_VERSION:=	3.11.10
KERNEL_MOD_VERSION:=	$(KERNEL_VERSION)
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		59f352d3f4e2cdf6755f79e09fa09176
endif
ifeq ($(ADK_KERNEL_VERSION_3_10_30),y)
KERNEL_VERSION:=	3.10.30
KERNEL_MOD_VERSION:=	$(KERNEL_VERSION)
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		f48ca7dd9f2eb14a2903cb6a4fbe07ed
endif
ifeq ($(ADK_KERNEL_VERSION_3_4_82),y)
KERNEL_VERSION:=	3.4.82
KERNEL_MOD_VERSION:=	$(KERNEL_VERSION)
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		9ee57efa65417a7a9ac931122c2b7377
endif
