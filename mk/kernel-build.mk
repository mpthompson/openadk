# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk
include $(ADK_TOPDIR)/mk/kernel-ver.mk
include $(ADK_TOPDIR)/mk/linux.mk
include $(ADK_TOPDIR)/mk/kernel-vars.mk

KERNEL_MODULES_USED:=$(shell grep ^ADK_KERNEL $(ADK_TOPDIR)/.config|grep =m)

KERNEL_FILE:=$(ADK_TARGET_KERNEL)
KERNEL_TARGET:=$(ADK_TARGET_KERNEL)
ifeq ($(ADK_TARGET_KERNEL_LINUXBIN),y)
KERNEL_FILE:=vmlinux
KERNEL_TARGET:=$(ADK_TARGET_KERNEL)
endif
ifeq ($(ADK_TARGET_KERNEL_ZIMAGE),y)
KERNEL_FILE:=vmlinux
KERNEL_TARGET:=$(ADK_TARGET_KERNEL)
endif
ifeq ($(ADK_TARGET_KERNEL_BZIMAGE),y)
KERNEL_FILE:=vmlinux
KERNEL_TARGET:=all
endif
ifeq ($(ADK_TARGET_KERNEL_IMAGE),y)
KERNEL_FILE:=vmlinux
KERNEL_TARGET:=$(ADK_TARGET_KERNEL)
endif

ifeq ($(ADK_RUNTIME_DEV_UDEV),y)
ADK_DEPMOD:=$(STAGING_HOST_DIR)/usr/bin/depmod
else
ADK_DEPMOD:=true
endif

$(LINUX_DIR)/.prepared: $(TOOLCHAIN_BUILD_DIR)/w-$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)/linux-$(KERNEL_FILE_VER)/.patched
	ln -sf $(TOOLCHAIN_BUILD_DIR)/w-$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)/linux-$(KERNEL_FILE_VER) $(LINUX_DIR)
	mkdir -p $(LINUX_BUILD_DIR)/kmod-control
	touch $@

$(LINUX_DIR)/.config: $(LINUX_DIR)/.prepared $(BUILD_DIR)/.kernelconfig
	$(START_TRACE) "target/$(ADK_TARGET_ARCH)-kernel-configure.. "
	-for f in $(TARGETS);do if [ -f $$f ];then rm $$f;fi;done
	echo "-${KERNEL_RELEASE}" >${LINUX_DIR}/localversion
ifeq ($(ADK_TARGET_KERNEL_USE_DEFCONFIG),y)
	${KERNEL_MAKE_ENV} $(MAKE) -C "${LINUX_DIR}" ${KERNEL_MAKE_OPTS} $(ADK_TARGET_KERNEL_DEFCONFIG) $(MAKE_TRACE)
else
	$(CP) $(BUILD_DIR)/.kernelconfig $(LINUX_DIR)/mini.config
	${KERNEL_MAKE_ENV} $(MAKE) -C "${LINUX_DIR}" ${KERNEL_MAKE_OPTS} KCONFIG_ALLCONFIG=mini.config allnoconfig $(MAKE_TRACE)
endif
	touch -c $(LINUX_DIR)/.config
	$(CMD_TRACE) " done"
	$(END_TRACE)

$(LINUX_DIR)/$(KERNEL_FILE): $(LINUX_DIR)/.config
	$(START_TRACE) "target/$(ADK_TARGET_ARCH)-kernel-compile.. "
	${KERNEL_MAKE_ENV} $(MAKE) -C "${LINUX_DIR}" ${KERNEL_MAKE_OPTS} -j${ADK_MAKE_JOBS} $(KERNEL_TARGET) $(MAKE_TRACE)
	touch -c $(LINUX_DIR)/$(KERNEL_FILE)
	$(CMD_TRACE) " done"
	$(END_TRACE)

$(LINUX_BUILD_DIR)/modules: $(LINUX_DIR)/$(KERNEL_FILE)
	$(START_TRACE) "target/$(ADK_TARGET_ARCH)-kernel-modules-compile.. "
	${KERNEL_MAKE_ENV} $(MAKE) -C "${LINUX_DIR}" ${KERNEL_MAKE_OPTS} -j${ADK_MAKE_JOBS} modules $(MAKE_TRACE)
	$(CMD_TRACE) " done"
	$(END_TRACE)
	$(START_TRACE) "target/$(ADK_TARGET_ARCH)-kernel-modules-install.. "
	rm -rf $(LINUX_BUILD_DIR)/modules
	${KERNEL_MAKE_ENV} $(MAKE) -C "${LINUX_DIR}" ${KERNEL_MAKE_OPTS} \
		DEPMOD=$(ADK_DEPMOD) \
		INSTALL_MOD_PATH=$(LINUX_BUILD_DIR)/modules \
		modules_install $(MAKE_TRACE)
	$(CMD_TRACE) " done"
	$(END_TRACE)
ifneq ($(ADK_RUNTIME_DEV_UDEV),y)
	$(START_TRACE) "target/$(ADK_TARGET_ARCH)-create-packages.. "
	@mkdir -p ${PACKAGE_DIR}
	PATH='${HOST_PATH}' ${BASH} ${SCRIPT_DIR}/make-module-ipkgs.sh \
		"${ADK_TARGET_CPU_ARCH}" \
		"${KERNEL_VERSION}" \
		"${LINUX_BUILD_DIR}" \
		"${PKG_BUILD}" \
		"${PACKAGE_DIR}"
	$(CMD_TRACE) " done"
	$(END_TRACE)
endif

prepare:
ifneq ($(KERNEL_MODULES_USED),)
compile: $(LINUX_BUILD_DIR)/modules
else
compile: $(LINUX_DIR)/$(KERNEL_FILE)
endif
install: compile
ifneq ($(KERNEL_MODULES_USED),)
	$(START_TRACE) "target/${ADK_TARGET_ARCH}-modules-install.. "
ifeq ($(ADK_TARGET_PACKAGE_IPKG)$(ADK_TARGET_PACKAGE_OPKG),y)
	$(PKG_INSTALL) $(wildcard ${PACKAGE_DIR}/kmod-*) $(MAKE_TRACE)
else
	$(foreach pkg,$(wildcard ${PACKAGE_DIR}/kmod-*),$(shell $(PKG_INSTALL) $(pkg)))
endif
	$(CMD_TRACE) " done"
	$(END_TRACE)
endif

clean:
	rm -rf $(LINUX_BUILD_DIR)
	rm -f $(wildcard ${PACKAGE_DIR}/kmod-*) $(wildcard ${PACKAGE_DIR}/kernel_*)
