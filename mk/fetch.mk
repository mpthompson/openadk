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
ifeq ($(strip ${NO_CHECKSUM}),)
${_CHECKSUM_COOKIE}: ${FULLDISTFILES}
	-rm -rf ${WRKDIR}
ifneq ($(ADK_DISABLE_CHECKSUM),y)
	@if [ ! -e ${FULLDISTFILES}.nohash ]; then \
	OK=n; \
	allsums="$(strip ${PKG_HASH})"; \
	(shasum -a 256 ${FULLDISTFILES}; echo exit) | while read sum name; do \
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
	    http://*|https://*|ftp://*) \
		for site in $${PKG_SITES} $${MASTER_SITE_BACKUP}; do \
			: echo "$${FETCH_CMD} $$$$site$$$$filename"; \
			rm -f "$$$$filename"; \
			if $${FETCH_CMD} $$$$site$$$$filename; then \
				: check the size here; \
				[[ ! -e $$$$filename ]] || exit 0; \
			fi; \
		done; \
		;; \
	   git://*) \
		rm -rf $${PKG_NAME}-$${PKG_VERSION}; \
		git clone $${PKG_SITES} $${PKG_NAME}-$${PKG_VERSION}; \
		if [ $$$$(echo $${PKG_VERSION}|wc -c) -eq 41 ]; then \
			(cd $${PKG_NAME}-$${PKG_VERSION}; \
			echo "Checking out $${PKG_VERSION}"; \
			git checkout -q $${PKG_VERSION}); \
		else \
			echo "Using head, disabling checksum check"; \
			touch $$$${filename}.nohash; \
		fi; \
		rm -rf $${PKG_NAME}-$${PKG_VERSION}/.git; \
		tar cJf $${PKG_NAME}-$${PKG_VERSION}.tar.xz $${PKG_NAME}-$${PKG_VERSION}; \
		rm -rf $${PKG_NAME}-$${PKG_VERSION}; \
		: check the size here; \
		[[ ! -e $$$$filename ]] || exit 0; \
		;; \
	   *) \
		echo url schema not known; \
		false ;; \
	esac; \
	done
endef

$(foreach distfile,${FULLDISTFILES},$(eval $(call FETCH_template,$(distfile))))
