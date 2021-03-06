# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		collectd
PKG_VERSION:=		5.5.0
PKG_RELEASE:=		1
PKG_HASH:=		5f7cfad5b24ed4f8b113cfb270e0f9e5a9f7c3af10443cb507fd40174a6c9028
PKG_DESCR:=		system statistics collection daemon
PKG_SECTION:=		sys/misc
PKG_BUILDDEP:=		libtool
PKG_DEPENDS:=		libltdl
PKG_NEEDS:=		threads
PKG_URL:=		http://collectd.org/
PKG_SITES:=		http://collectd.org/files/

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

PKG_FLAVOURS_COLLECTD:=	WITH_CPU WITH_LOAD WITH_MEMORY WITH_PING
PKG_FLAVOURS_COLLECTD+=	WITH_RRD WITH_NETWORK WITH_UPTIME
PKGFD_WITH_RRD:=	enable RRD output
PKGFB_WITH_RRD:=	rrdtool
PKGFS_WITH_RRD:=	librrd
PKGFD_WITH_CPU:=	collect CPU statistics
PKGFD_WITH_LOAD:=	collect system load statistics
PKGFD_WITH_MEMORY:=	collect memory usage statistics
PKGFD_WITH_PING:=	enable ping statistic plugin
PKGFD_WITH_NETWORK:=	enable network statistic plugin
PKGFD_WITH_UPTIME:=	enable uptime statistic plugin

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,COLLECTD,collectd,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

XAKE_FLAGS:=		V=1

ifneq (${ADK_PACKAGE_COLLECTD_WITH_CPU},y)
DISABLE_CPU:=--disable-cpu
endif
ifneq (${ADK_PACKAGE_COLLECTD_WITH_LOAD},y)
DISABLE_LOAD:=--disable-load
endif
ifneq (${ADK_PACKAGE_COLLECTD_WITH_MEMORY},y)
DISABLE_MEMORY:=--disable-memory
endif
ifneq (${ADK_PACKAGE_COLLECTD_WITH_PING},y)
DISABLE_PING:=--disable-ping
endif
ifneq (${ADK_PACKAGE_COLLECTD_WITH_NETWORK},y)
DISABLE_NETWORK:=--disable-network
endif
ifneq (${ADK_PACKAGE_COLLECTD_WITH_UPTIME},y)
DISABLE_UPTIME:=--disable-uptime
endif

CONFIGURE_ARGS+=	--disable-aggregation \
			--disable-apache \
			--disable-apcups \
			--disable-apple_sensors \
			--disable-ascent \
			--disable-battery \
			--disable-cgroups \
			--disable-conntrack \
			${DISABLE_CPU} \
			--disable-cpufreq \
			--disable-contextswitch \
			--disable-disk \
			--enable-csv \
			--disable-df \
			--disable-dns \
			--disable-email \
			--disable-entropy \
			--disable-ethstat \
			--disable-exec \
			--disable-filecount \
			--disable-fscache \
			--disable-hddtemp \
			--disable-interface \
			--disable-iptables \
			--disable-ipvs \
			--disable-irq \
			${DISABLE_LOAD} \
			--disable-madwifi \
			--disable-mbmon \
			--disable-md \
			--disable-memcached \
			${DISABLE_MEMORY} \
			--disable-multimeter \
			--disable-mysql \
			${DISABLE_NETWORK} \
			--disable-nginx \
			--disable-nfs \
			--disable-ntpd \
			--disable-numa \
			--disable-nut \
			--disable-olsrd \
			--disable-openvpn \
			--disable-python \
			--disable-postgresql \
			--disable-powerdns \
			--disable-perl \
			${DISABLE_PING} \
			--disable-processes \
			--disable-protocols \
			--disable-sensors \
			--disable-serial \
			--disable-logfile \
			--disable-statsd \
			--disable-swap \
			--enable-syslog \
			--disable-tape \
			--disable-target_notification \
			--disable-target_replace \
			--disable-target_set \
			--disable-tcpconns \
			--disable-teamspeak2 \
			--disable-ted \
			--disable-thermal \
			--disable-unixsock \
			--disable-users \
			${DISABLE_UPTIME} \
			--disable-uuid \
			--disable-vserver \
			--disable-wireless \
			--disable-write_graphite \
			--disable-write_http \
			--with-fp-layout=nothing \
			--without-java \
			--without-python \
			--without-libiptc \
			--with-nan-emulation

XAKE_FLAGS+=		LIBS='-lm -lltdl'

collectd-install:
	${INSTALL_DIR} ${IDIR_COLLECTD}/usr/lib/collectd \
		${IDIR_COLLECTD}/usr/sbin ${IDIR_COLLECTD}/etc
	${INSTALL_DIR} ${IDIR_COLLECTD}/usr/share/collectd
	${CP} ${WRKINST}/usr/share/collectd/types.db \
		${IDIR_COLLECTD}/usr/share/collectd
	${INSTALL_BIN} ${WRKINST}/usr/sbin/collectd ${IDIR_COLLECTD}/usr/sbin
	${CP} ${WRKINST}/usr/lib/collectd/*.so \
		${IDIR_COLLECTD}/usr/lib/collectd
	${INSTALL_DATA} ./files/collectd.conf \
		${IDIR_COLLECTD}/etc

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
