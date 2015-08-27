menu "Filesystems support"

config ADK_KERNEL_MISC_FILESYSTEMS
	bool

config ADK_KERNEL_FSNOTIFY
	bool
	default y

config ADK_KERNEL_EXPORTFS
	bool

config ADK_KERNEL_JBD2
	tristate
	select ADK_KERNEL_CRC32
	select ADK_KERNEL_CRYPTO
	select ADK_KERNEL_CRYPTO_CRC32C

config ADK_KERNEL_YAFFS_YAFFS1
	bool

config ADK_KERNEL_YAFFS_YAFFS2
	bool

config ADK_KERNEL_YAFFS_AUTO_YAFFS2
	bool

config ADK_KERNEL_DNOTIFY
	bool

config ADK_KERNEL_EXT3_FS_XATTR
	bool

config ADK_KERNEL_FAT_DEFAULT_CODEPAGE
	int
	default 850

config ADK_KERNEL_FAT_DEFAULT_IOCHARSET
	string
	default "iso8859-1"

config ADK_KERNEL_SQUASHFS_XZ
	bool

config ADK_KERNEL_JFFS2_COMPRESSION_OPTIONS
	bool

config ADK_KERNEL_JFFS2_ZLIB
	bool

menu "Filesystems"

config ADK_KERNEL_EXT2_FS
	tristate "EXT2 filesystem support"
	default y if ADK_TARGET_SYSTEM_LEMOTE_YEELONG
	default n
	help
	  Ext2 is a standard Linux file system for hard disks.

config ADK_KERNEL_EXT3_FS
	tristate "EXT3 filesystem support"
	help
	  This is the journalling version of the Second extended file system
	  (often called ext3), the de facto standard Linux file system
	  (method to organize files on a storage device) for hard disks.

	  The journalling code included in this driver means you do not have
	  to run e2fsck (file system checker) on your file systems after a
	  crash.  The journal keeps track of any changes that were being made
	  at the time the system crashed, and can ensure that your file system
	  is consistent without the need for a lengthy check.

	  Other than adding the journal to the file system, the on-disk format
	  of ext3 is identical to ext2.  It is possible to freely switch
	  between using the ext3 driver and the ext2 driver, as long as the
	  file system has been cleanly unmounted, or e2fsck is run on the file
	  system.

	  To add a journal on an existing ext2 file system or change the
	  behavior of ext3 file systems, you can use the tune2fs utility ("man
	  tune2fs").  To modify attributes of files and directories on ext3
	  file systems, use chattr ("man chattr").  You need to be using
	  e2fsprogs version 1.20 or later in order to create ext3 journals
	  (available at <http://sourceforge.net/projects/e2fsprogs/>).

config ADK_KERNEL_EXT4_FS
	tristate "EXT4 filesystem support"
	select ADK_KERNEL_JBD2
	help
	  Ext4 filesystem.

config ADK_KERNEL_HFSPLUS_FS
	tristate "HFS+ filesystem support"
	select ADK_KERNEL_NLS_UTF8
	select ADK_KERNEL_MISC_FILESYSTEMS
	help
	  If you say Y here, you will be able to mount extended format
	  Macintosh-formatted hard drive partitions with full read-write access.

	  This file system is often called HFS+ and was introduced with
	  MacOS 8. It includes all Mac specific filesystem data such as
	  data forks and creator codes, but it also has several UNIX
	  style features such as file ownership and permissions.

config ADK_KERNEL_NTFS_FS
	tristate "NTFS file system support"
	help
	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.

	  Saying Y or M here enables read support.  There is partial, but
	  safe, write support available.  For write support you must also
	  say Y to "NTFS write support" below.

	  There are also a number of user-space tools available, called
	  ntfsprogs.  These include ntfsundelete and ntfsresize, that work
	  without NTFS support enabled in the kernel.

	  This is a rewrite from scratch of Linux NTFS support and replaced
	  the old NTFS code starting with Linux 2.5.11.  A backport to
	  the Linux 2.4 kernel series is separately available as a patch
	  from the project web site.

	  For more information see <file:Documentation/filesystems/ntfs.txt>
	  and <http://linux-ntfs.sourceforge.net/>.

	  If you are not using Windows NT, 2000, XP or 2003 in addition to
	  Linux on your computer it is safe to say N.
	  Kernel modules for NTFS support

config ADK_KERNEL_VFAT_FS
	tristate "VFAT filesystem support"
	select ADK_KERNEL_NLS_CODEPAGE_850
	select ADK_KERNEL_NLS_ISO8859_1
	default y if ADK_TARGET_BOARD_BCM28XX
	default n
	help
	  This option provides support for normal Windows file systems with
	  long filenames.  That includes non-compressed FAT-based file systems
	  used by Windows 95, Windows 98, Windows NT 4.0, and the Unix
	  programs from the mtools package.

	  The VFAT support enlarges your kernel by about 10 KB Please read the
	  file <file:Documentation/filesystems/vfat.txt> for details.


config ADK_KERNEL_XFS_FS
	tristate "XFS filesystem support"
	select ADK_KERNEL_EXPORTFS
	select ADK_KERNEL_LIBCRC32C
	help
	  XFS is a high performance journaling filesystem which originated
	  on the SGI IRIX platform.  It is completely multi-threaded, can
	  support large files and large filesystems, extended attributes,
	  variable block sizes, is extent based, and makes extensive use of
	  Btrees (directories, extents, free space) to aid both performance
	  and scalability.

	  Refer to the documentation at <http://oss.sgi.com/projects/xfs/>
	  for complete details.  This implementation is on-disk compatible
	  with the IRIX version of XFS.

config ADK_KERNEL_BTRFS_FS
	tristate "Btrfs filesystem support"
	select ADK_KERNEL_CRYPTO_CRC32C
	select ADK_KERNEL_RAID6_PQ
	select ADK_KERNEL_XOR_BLOCKS
	select ADK_KERNEL_ZLIB_DEFLATE
	select ADK_KERNEL_LZO_COMPRESS
	select ADK_KERNEL_LZO_DECOMPRESS
	help
	  Btrfs is a general purpose copy-on-write filesystem with extents,
	  writable snapshotting, support for multiple devices and many more
	  features focused on fault tolerance, repair and easy administration.
	  For more information, please see the web pages at
	  http://btrfs.wiki.kernel.org

config ADK_KERNEL_FUSE_FS
	tristate "Filesystem in Userspace support"
	help
	  With FUSE it is possible to implement a fully functional
	  filesystem in a userspace program.

	  By enabling this, only the kernel module gets build.
	  For using it, you will most likely also want to enable
	  fuse-utils.

config ADK_KERNEL_JOLIET
	bool 

config ADK_KERNEL_ISO9660_FS
	tristate "ISO 9660 / JOLIET CDROM file system support"
	select ADK_KERNEL_JOLIET
	help
	  This is the standard file system used on CD-ROMs.  It was previously
	  known as "High Sierra File System" and is called "hsfs" on other
	  Unix systems.  The so-called Rock-Ridge extensions which allow for
	  long Unix filenames and symbolic links are also supported by this
	  driver.  If you have a CD-ROM drive and want to do more with it than
	  just listen to audio CDs and watch its LEDs, say Y (and read
	  <file:Documentation/filesystems/isofs.txt> and the CD-ROM-HOWTO,
	  available from <http://www.tldp.org/docs.html#howto>), thereby
	  enlarging your kernel by about 27 KB; otherwise say N.

config ADK_KERNEL_UDF_FS
	tristate "UDF file system support"
	select ADK_KERNEL_CRC_ITU_T
	help
	  This is the new file system used on some CD-ROMs and DVDs. Say Y if
	  you intend to mount DVD discs or CDRW's written in packet mode, or
	  if written to by other UDF utilities, such as DirectCD.
	  Please read <file:Documentation/filesystems/udf.txt>.

config ADK_KERNEL_JFFS2_FS
	tristate "JFFS2 filesystem"
	select ADK_KERNEL_MISC_FILESYSTEMS
	select ADK_KERNEL_MTD
	select ADK_KERNEL_MTD_BLOCK
	select ADK_KERNEL_JFFS2_COMPRESSION_OPTIONS
	select ADK_KERNEL_JFFS2_ZLIB
	depends on ADK_TARGET_WITH_MTD
	help
	  JFFS2 flash filesystem

config ADK_KERNEL_SQUASHFS
	tristate "SquashFS filesystem"
	select ADK_KERNEL_MISC_FILESYSTEMS
	select ADK_KERNEL_SQUASHFS_XZ
	help
	  Squashfs compressed read-only filesystem

config ADK_KERNEL_YAFFS_FS
	tristate "YAFFS2 filesystem"
	select ADK_KERNEL_MISC_FILESYSTEMS
	select ADK_KERNEL_MTD
	select ADK_KERNEL_MTD_BLOCK
	select ADK_KERNEL_YAFFS_YAFFS1
	select ADK_KERNEL_YAFFS_YAFFS2
	select ADK_KERNEL_YAFFS_AUTO_YAFFS2
	depends on ADK_TARGET_WITH_NAND
	help
	  YAFFS2 filesystem for NAND devices

endmenu

menu "Filesystem features"

config ADK_KERNEL_INOTIFY_USER
	bool "Inotify support for userspace"
	default y
	help
	  Say Y here to enable inotify support for userspace, including the
	  associated system calls.  Inotify allows monitoring of both files and
	  directories via a single open fd.  Events are read from the file
	  descriptor, which is also select()- and poll()-able.

endmenu
source target/linux/config/Config.in.part
source target/linux/config/Config.in.fsnet
source target/linux/config/Config.in.nls
source target/linux/config/Config.in.aufs

endmenu
