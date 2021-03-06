# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

define rootfs_template
ifeq ($(ADK_TARGET_ROOTFS_$(2)),y)
ADK_TARGET_FS:=$(1)
FS_CMDLINE:=$(3)
endif
endef

ifeq ($(ADK_TARGET_QEMU),y)
MTDDEV:=	root=/dev/mtdblock0
ifeq ($(ADK_TARGET_ROOTFS_ARCHIVE),y)
ifeq ($(ADK_TARGET_QEMU_WITH_VIRTIO),y)
ROOTFS:=	root=/dev/vda1
else
ROOTFS:=	root=/dev/sda1 rootwait
endif
endif
ifeq ($(ADK_TARGET_SYSTEM_QEMU_ARM_VEXPRESS_A9),y)
ROOTFS:=	root=/dev/mmcblk0p1
endif
endif

ifeq ($(ADK_TARGET_SYSTEM_MIKROTIK_RB532),y)
ROOTFS:=	root=/dev/sda2
MTDDEV:=	root=/dev/mtdblock1
endif

ifeq ($(ADK_TARGET_SYSTEM_MIKROTIK_RB4XX),y)
MTDDEV:=	root=/dev/mtdblock7
endif

ifeq ($(ADK_TARGET_SYSTEM_ACMESYSTEMS_FOXG20),y)
ROOTFS:=	root=/dev/mmcblk0p2 rootwait
endif

ifeq ($(ADK_TARGET_SYSTEM_SHARP_ZAURUS),y)
ROOTFS:=	root=/dev/sda1 rootwait
endif

ifeq ($(ADK_TARGET_SYSTEM_RASPBERRY_PI),y)
ROOTFS:=	root=/dev/mmcblk0p2 rootwait
endif

ifeq ($(ADK_TARGET_SYSTEM_SOLIDRUN_IMX6),y)
ROOTFS:=	root=/dev/mmcblk0p1 rootwait
endif

ifeq ($(ADK_TARGET_SYSTEM_LEMOTE_YEELONG),y)
USB:=		rootwait root=/dev/sdb1
else
USB:=		rootdelay=2
endif

$(eval $(call rootfs_template,usb,USB,$(USB)))
$(eval $(call rootfs_template,archive,ARCHIVE,$(ROOTFS)))
$(eval $(call rootfs_template,initramfs,INITRAMFS,rootfstype=tmpfs))
$(eval $(call rootfs_template,initramfspiggyback,INITRAMFSPIGGYBACK,rootfstype=tmpfs))
$(eval $(call rootfs_template,initramfsarchive,INITRAMFSARCHIVE,rootfstype=tmpfs))
$(eval $(call rootfs_template,squashfs,SQUASHFS,$(MTDDEV) rootfstype=squashfs))
$(eval $(call rootfs_template,yaffs,YAFFS,$(MTDDEV) panic=3))
$(eval $(call rootfs_template,jffs2,JFFS2,$(MTDDEV) rootfstype=jffs2))
$(eval $(call rootfs_template,nfsroot,NFSROOT,root=/dev/nfs ip=dhcp))
$(eval $(call rootfs_template,encrypted,ENCRYPTED))
$(eval $(call rootfs_template,iso,ISO))

export ADK_TARGET_FS
