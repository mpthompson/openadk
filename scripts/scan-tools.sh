# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

shopt -s extglob
topdir=$(pwd)
opath=$PATH
out=0
clang=0

if [[ $NO_ERROR != @(0|1) ]]; then
	echo Please do not invoke this script directly!
	exit 1
fi

set -e
rm -rf $topdir/tmp
mkdir -p $topdir/tmp
cd $topdir/tmp

os=$(uname)

rm -f foo
echo >FOO
if [[ -e foo ]]; then
	cat >&2 <<-EOF
		ERROR: OpenADK cannot be built in a case-insensitive file system. 
	EOF
	case $os in
		CYG*)
			echo "Building OpenADK on $os needs a small registry change."
			echo 'http://cygwin.com/cygwin-ug-net/using-specialnames.html'
			;;
		Darwin*)
			echo "Building OpenADK on $os needs a case-sensitive disk partition."
			echo "For Snow Leopard and above you can use diskutil to resize your existing disk."
			echo "Example: sudo diskutil resizeVolume disk0s2 90G 1 jhfsx adk 30G"
			echo "For older versions you might consider to use a disk image:"
			echo "hdiutil create -type SPARSE -fs 'Case-sensitive Journaled HFS+' -size 30g ~/openadk.dmg"
			;;
	esac
	exit 1
fi
rm -f FOO

case $os in
Linux)
	;;
FreeBSD)
	if ! which gmake >/dev/null 2>&1; then
		echo You must install GNU make to continue.
		echo
		out=1
	fi
	clang=1
	;;
MirBSD)
	;;
CYG*)
	;;
NetBSD)
	;;
OpenBSD)
	if ! which gmake >/dev/null 2>&1; then
		echo You must install GNU make to continue.
		echo
		out=1
	fi
	;;
Darwin*)
	clang=1
	;;
*)
	# unsupported
	echo "Building OpenADK on $os is currently unsupported."
	echo "Sorry."
	exit 1
	;;
esac

set +e

if [ -z $(which gmake 2>/dev/null ) ];then
	makecmd=$(which make 2>/dev/null )
else
	makecmd=$(which gmake 2>/dev/null )
fi

cat >Makefile <<'EOF'
include ${ADK_TOPDIR}/prereq.mk
all: run-test

test: test.c
	${HOST_CC} ${HOST_CFLAGS} -o $@ $^ ${LDADD}

run-test: test
	./test
EOF
cat >test.c <<-'EOF'
	#include <stdio.h>
	int
	main()
	{
		printf("Yay! Native compiler works.\n");
		return (0);
	}
EOF
if [[ $clang -eq 0 ]]; then
  X=$($makecmd ADK_TOPDIR=$topdir LDADD=-lgcc 2>&1)
  if [[ $X != *@(Native compiler works)* ]]; then
	echo Cannot compile with shared libgcc use static one.
	HOST_CFLAGS=-static-libgcc
	echo "HOST_CFLAGS:=-O0 -g0 -static-libgcc" >> $topdir/prereq.mk
	echo "HOST_CXXFLAGS:=-O0 -g0 -static-libgcc" >> $topdir/prereq.mk
  else
	echo "HOST_CFLAGS:=-O0 -g0" >> $topdir/prereq.mk
	echo "HOST_CXXFLAGS:=-O0 -g0" >> $topdir/prereq.mk
  fi
else
  echo "HOST_CFLAGS:=-O0 -g0" >> $topdir/prereq.mk
  echo "HOST_CXXFLAGS:=-O0 -g0" >> $topdir/prereq.mk
fi

X=$($makecmd ADK_TOPDIR=$topdir HOST_CFLAGS=${HOST_CFLAGS} 2>&1)
if [[ $X != *@(Native compiler works)* ]]; then
	echo "$X" | sed 's/^/| /'
	echo Cannot compile a simple test programme.
	echo You must install a host make and C compiler,
	echo usually GCC, to proceed.
	echo
	out=1
fi
rm test 2>/dev/null

if ! which shasum >/dev/null 2>&1; then
  if ! which sha256sum >/dev/null 2>&1; then
    if ! which cksum >/dev/null 2>&1; then
	echo You must install shasum or sha256sum or cksum to continue.
	echo
	out=1
    fi
  fi
fi

if ! which gzip >/dev/null 2>&1; then
	echo You must install gzip to continue.
	echo
	out=1
fi

cat >test.c <<-'EOF'
	#include <stdio.h>
	#include <zlib.h>

	#ifndef STDIN_FILENO
	#define STDIN_FILENO 0
	#endif

	int
	main()
	{
		gzFile zstdin;
		char buf[1024];
		int i;

		zstdin = gzdopen(STDIN_FILENO, "rb");
		i = gzread(zstdin, buf, sizeof (buf));
		if ((i > 0) && (i < sizeof (buf)))
			buf[i] = '\0';
		buf[sizeof (buf) - 1] = '\0';
		printf("%s\n", buf);
		return (0);
	}
EOF
X=$(echo 'Yay! Native compiler works.' | gzip | \
    $makecmd ADK_TOPDIR=$topdir LDADD=-lz HOST_CFLAGS=${HOST_CFLAGS} 2>&1)
if [[ $X != *@(Native compiler works)* ]]; then
	echo "$X" | sed 's/^/| /'
	echo Cannot compile a libz test programm.
	echo You must install the zlib development package,
	echo usually called libz-dev, and the run-time library.
	echo
	out=1
fi

if [[ ! -s /usr/include/ncursesw/curses.h && \
    ! -s /usr/include/ncurses.h && \
    ! -s /usr/include/curses.h && \
    ! -s /usr/include/ncurses/ncurses.h && \
    ! -s /usr/local/opt/ncurses/include/ncursesw/ncurses.h ]]; then
	echo Install ncurses header files, please.
	echo
	out=1
fi

if ! which wget >/dev/null 2>&1; then
	echo You must install wget to continue.
	echo
	out=1
fi

if ! which perl >/dev/null 2>&1; then
	echo You must install perl to continue.
	echo
	out=1
fi

if ! which g++ >/dev/null 2>&1; then
  if ! which clang++ >/dev/null 2>&1; then
    echo  "You need a C++ compiler to continue."
    echo
    out=1
  fi
fi

# always required, but can be provided by host
host_build_bc=0
if which bc >/dev/null 2>&1; then
  if ! echo quit|bc -q 2>/dev/null >/dev/null; then
    host_build_bc=1
  else 
    if bc -v 2>&1| grep -q BSD >/dev/null 2>&1; then
      host_build_bc=1
    fi 
  fi
else
  host_build_bc=1
fi

host_build_bison=0
if ! which bison >/dev/null 2>&1; then
	host_build_bison=1
fi

host_build_bzip2=0
if ! which bzip2 >/dev/null 2>&1; then
	host_build_bzip2=1
fi

host_build_file=0
if ! which file >/dev/null 2>&1; then
	host_build_file=1
fi

host_build_flex=0
if ! which flex >/dev/null 2>&1; then
	host_build_flex=1
fi

host_build_m4=0
if ! which m4 >/dev/null 2>&1; then
	host_build_m4=1
fi

host_build_mksh=0
if ! which mksh >/dev/null 2>&1; then
	host_build_mksh=1
fi

host_build_patch=0
if ! which patch >/dev/null 2>&1; then
	host_build_patch=1
fi

host_build_pkgconf=0
if ! which pkgconf >/dev/null 2>&1; then
	host_build_pkgconf=1
fi

host_build_tar=0
if which tar >/dev/null 2>&1; then
	if ! tar --version 2>/dev/null|grep GNU >/dev/null;then
		host_build_tar=1
	fi
else
	host_build_tar=1
fi

host_build_findutils=0
if ! which gxargs >/dev/null 2>&1; then
	if which xargs >/dev/null 2>&1; then
		if ! xargs --version 2>/dev/null|grep GNU >/dev/null;then
			host_build_findutils=1
		fi
	fi
fi

if which find >/dev/null 2>&1; then
	if ! find --version 2>/dev/null|grep GNU >/dev/null;then
		host_build_findutils=1
	fi
fi

host_build_grep=0
if which grep >/dev/null 2>&1; then
	if ! grep --version 2>/dev/null|grep GNU >/dev/null;then
		host_build_grep=1
	fi
fi

host_build_gawk=0
if ! which gawk >/dev/null 2>&1; then
	host_build_gawk=1
fi

host_build_sed=0
if which sed >/dev/null 2>&1; then
	if ! sed --version 2>/dev/null|grep GNU >/dev/null;then
		host_build_sed=1
	fi
fi

host_build_xz=0
if ! which xz >/dev/null 2>&1; then
	host_build_xz=1
fi

# optional
host_build_cdrtools=0
if ! which mkisofs >/dev/null 2>&1; then
	host_build_cdrtools=1
fi

host_build_ccache=0
if ! which ccache >/dev/null 2>&1; then
	host_build_ccache=1
fi

host_build_genext2fs=0
if ! which genext2fs >/dev/null 2>&1; then
	host_build_genext2fs=1
fi

host_build_lzma=0
if ! which lzma >/dev/null 2>&1; then
	host_build_lzma=1
fi

host_build_lz4=0
if ! which lz4c >/dev/null 2>&1; then
	host_build_lz4=1
fi

host_build_lzop=0
if ! which lzop >/dev/null 2>&1; then
	host_build_lzop=1
fi

host_build_qemu=0
if ! which qemu-img >/dev/null 2>&1; then
	host_build_qemu=1
fi

echo "config ADK_HOST_BUILD_TOOLS" > $topdir/target/config/Config.in.prereq
printf "\t%s\n" "bool" >> $topdir/target/config/Config.in.prereq
printf "\t%s\n" "default y" >> $topdir/target/config/Config.in.prereq
# always required
if [ $host_build_bc -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_BC" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_bison -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_BISON" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_bzip2 -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_BZIP2" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_file -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_FILE" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_flex -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_FLEX" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_gawk -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_GAWK" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_grep -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_GREP" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_m4 -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_M4" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_mksh -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_MKSH" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_patch -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_PATCH" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_pkgconf -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_PKGCONF" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_findutils -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_FINDUTILS" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_sed -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_SED" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_tar -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_TAR" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_xz -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_XZ" >> $topdir/target/config/Config.in.prereq ;fi
# optional
if [ $host_build_ccache -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_CCACHE if ADK_HOST_NEED_CCACHE" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_cdrtools -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_CDRTOOLS if ADK_HOST_NEED_CDRTOOLS" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_genext2fs -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_GENEXT2FS if ADK_HOST_NEED_GENEXT2FS" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_lzma -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_LZMA if ADK_HOST_NEED_LZMA" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_lz4 -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_LZ4 if ADK_HOST_NEED_LZ4" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_lzop -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_LZOP if ADK_HOST_NEED_LZOP" >> $topdir/target/config/Config.in.prereq ;fi
if [ $host_build_qemu -eq 1 ];then printf "\t%s\n" "select ADK_HOST_BUILD_QEMU if ADK_HOST_NEED_QEMU" >> $topdir/target/config/Config.in.prereq ;fi

cd $topdir
rm -rf tmp

exit $out
