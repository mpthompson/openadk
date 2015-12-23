# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.
#
# On the various kernel version variables:
#
# KERNEL_FILE_VER: version numbering used for tarball and contained top level
#                  directory (e.g. linux-4.1.2.tar.bz2 -> linux-4.1.2) (not
#                  necessary equal to kernel's version, e.g. linux-3.19
#                  contains kernel version 3.19.0)
# KERNEL_RELEASE:  OpenADK internal versioning
# KERNEL_VERSION:  final kernel version how we want to identify a specific kernel

ifeq ($(ADK_TARGET_KERNEL_VERSION_GIT),y)
KERNEL_FILE_VER:=	$(ADK_TARGET_KERNEL_HASH)
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_4_3_3),y)
KERNEL_FILE_VER:=	4.3.3
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		8cad4ce7d049c2ecc041b0844bd478bf85f0d3071c93e0c885a776d57cbca3cf
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_4_1_15),y)
KERNEL_FILE_VER:=	4.1.15
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		472288cc966188c5d7c511c6be0f78682843c9ca2d5d6c4d67d77455680359a3
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_18_25),y)
KERNEL_FILE_VER:=	3.18.25
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		c649874e2856101df7cefe5fdad313ebb2282a939fc1e95cf02222327745ff92
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_14_58),y)
KERNEL_FILE_VER:=	3.14.58
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		f4d016cb807b294988c6515c245939b2a7987ba606ad0662958bd8cb8600814b
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_12_51),y)
KERNEL_FILE_VER:=	3.12.51
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		7199a5beaa9b3a6eb3aa30b62d5e66aa333bb4cf5efe715a5d1067f4f68f1820
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_10_94),y)
KERNEL_FILE_VER:=	3.10.94
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		61a700b21ad951c8bc2ed9d3ff3c3c5c6e4124a1f2808f786745d568290cba7f
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_4_110),y)
KERNEL_FILE_VER:=	3.4.110
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		3bc608bc722755128f14ab4a31b973789e23753d6ac8db417498d0f9911ce7d0
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_2_74),y)
KERNEL_FILE_VER:=	3.2.74
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		9271c9b72f70cc57a414c8de93e1eeaab48dfd7a2d147d24a116e8f49b17ed75
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_2_6_32_69),y)
KERNEL_FILE_VER:=	2.6.32.69
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		3412b1ae5e8f7a5266a602fb3022e802091c10595c6ecf4a790214a833bf034d
endif
