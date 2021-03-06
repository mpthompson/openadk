# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

ifneq ($(strip ${DIST_SUBDIR}),)
FULLDISTDIR?=		${DL_DIR}/${DIST_SUBDIR}
else
FULLDISTDIR?=		${DL_DIR}
endif

FULLDISTFILES=		$(patsubst %,${FULLDISTDIR}/%,${DISTFILES})

FETCH_STYLE?=		auto
do-fetch:
fetch:
ifneq ($(filter auto,${FETCH_STYLE}),)
	${MAKE} ${FULLDISTFILES}
else
	${MAKE} do-fetch
endif

refetch:
	-rm -f ${FULLDISTFILES}
	${MAKE} fetch

_CHECKSUM_COOKIE?=	${WRKDIR}/.checksum_done
checksum: ${_CHECKSUM_COOKIE}
ifeq ($(strip ${PKG_NOCHECKSUM}),)
${_CHECKSUM_COOKIE}: ${FULLDISTFILES}
	-rm -rf ${WRKDIR}
ifneq ($(ADK_DISABLE_CHECKSUM),y)
	@if [ ! -e $(firstword ${FULLDISTFILES}).nohash ]; then \
	OK=n; \
	allsums="$(strip ${PKG_HASH})"; \
	($${SHA256} ${FULLDISTFILES}; echo exit) | while read sum name; do \
		if [[ $$sum = exit ]]; then \
			[[ $$OK = n ]] && echo >&2 "==> No distfile found!" || :; \
			[[ $$OK = 1 ]] || exit 1; \
			break; \
		fi; \
		cursum="$${allsums%% *}"; \
		allsums="$${allsums#* }"; \
		if [[ $$sum = "$$cursum" ]]; then \
			[[ $$OK = 0 ]] || OK=1; \
			continue; \
		fi; \
		echo >&2 "==> Checksum mismatch for $${name##*/} (SHA256)"; \
		echo >&2 ":---> should be '$$cursum'"; \
		echo >&2 ":---> really is '$$sum'"; \
		OK=0; \
	done; \
	fi
endif
	mkdir -p ${WRKDIR}
	touch ${_CHECKSUM_COOKIE}
endif

# GNU make's poor excuse for loops
define FETCH_template
$(1):
	@fullname='$(1)'; \
	filename=$$$${fullname##*/}; \
	mkdir -p "$$$${fullname%%/$$$$filename}"; \
	cd "$$$${fullname%%/$$$$filename}"; \
	for url in "${PKG_SITES}"; do case $$$$url in \
	   git://*|*.git) \
		rm -rf $${PKG_NAME}-$${PKG_VERSION}; \
		if [ ! -z "$${PKG_GIT}" ]; then \
		  case "$${PKG_GIT}" in \
		    tag|branch) \
			echo "Using git tag/branch: $${PKG_VERSION}"; \
			git clone --depth 1 --branch $${PKG_VERSION} $(GITOPTS) $${PKG_SITES} $${PKG_NAME}-$${PKG_VERSION}; \
			;; \
		    hash) \
			echo "Using git hash: $${PKG_VERSION}"; \
			git clone $(GITOPTS) $${PKG_SITES} $${PKG_NAME}-$${PKG_VERSION}; \
			(cd $${PKG_NAME}-$${PKG_VERSION}; git checkout $(GITOPTS) $${PKG_VERSION}); \
			;; \
		  esac ;\
		else \
		  git clone --depth 1 $(GITOPTS) $${PKG_SITES} $${PKG_NAME}-$${PKG_VERSION}; \
		fi; \
		tar cJf $${PKG_NAME}-$${PKG_VERSION}.tar.xz $${PKG_NAME}-$${PKG_VERSION}; \
		touch $$$${filename}.nohash; \
		rm -rf $${PKG_NAME}-$${PKG_VERSION}; \
		: check the size here; \
		[[ ! -e $$$$filename ]] || exit 0; \
		;; \
	    http://*|https://*|ftp://*) \
		for site in $${PKG_SITES} $${MASTER_SITE_BACKUP}; do \
			: echo "$${FETCHCMD} $$$$site$$$$filename"; \
			rm -f "$$$$filename"; \
			if $${FETCHCMD} $$$$filename $$$$site$$$$filename $(DL_TRACE); then \
				: check the size here; \
				[[ ! -e $$$$filename ]] || exit 0; \
			fi; \
		done; \
		;; \
	   *) \
		echo url schema not known; \
		false ;; \
	esac; \
	done
endef

$(foreach distfile,${FULLDISTFILES},$(eval $(call FETCH_template,$(distfile))))
