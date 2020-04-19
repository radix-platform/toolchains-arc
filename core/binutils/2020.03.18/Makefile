

COMPONENT_TARGETS  = $(TOOLCHAIN_S8XX_NEWLIB)


include ../../../build-system/config.mk


SOURCE_REQUIRES  = sources/binutils

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive       = $(SRC_PACKAGE_PATH)/binutils/binutils-gdb-arc-2020.03.18.tar.xz
SRC_ARCHIVE          = $(tar_xz_archive)
SRC_DIR              = $(TARGET_BUILD_DIR)/binutils-gdb-arc-2020.03.18
src_dir_name         = binutils-gdb-arc-2020.03.18
src_done             = $(SRC_DIR)/.source-done

PATCHES       = PATCHES

build_dir            = $(TARGET_BUILD_DIR)/build
install_dir          = $(TOOLCHAIN_PATH)

sysroot_dir          = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

build_target         = $(TARGET_BUILD_DIR)/.built
install_target       = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(install_target)

include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_NEWLIB))
extra_configure_switches  = --with-cpu=arcem
extra_configure_switches += --with-endian=little
extra_configure_switches += --disable-multilib
extra_configure_switches += --disable-werror
endif


$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(build_target): $(src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)                     \
	  --target=$(TARGET)                             \
	  --infodir=$(TOOLCHAIN_PATH)/share/info         \
	  --mandir=$(TOOLCHAIN_PATH)/share/man           \
	  $(extra_configure_switches)
	@$(MAKE) -C $(build_dir) all-{binutils,gas,ld}
	@touch $@

$(install_target): $(build_target)
	@mkdir -p $(install_dir)
	@$(MAKE) -j1 -C $(build_dir) pdf-{binutils,gas,ld}
	@$(MAKE) -j1 -C $(build_dir) install-{,pdf-}{binutils,gas,ld}
	@echo ""                                       > $(TOOLCHAIN_PATH)/README
	@echo "  TOOLCHAIN = $(TOOLCHAIN)"            >> $(TOOLCHAIN_PATH)/README
	@echo "     TARGET = $(TARGET)"               >> $(TOOLCHAIN_PATH)/README
	@echo "  BASE_PATH = $(TOOLCHAINS_BASE_PATH)" >> $(TOOLCHAIN_PATH)/README
	@echo "  DIRECTORY = $(TOOLCHAIN_DIR)"        >> $(TOOLCHAIN_PATH)/README
	@echo "    VERSION = $(TOOLCHAIN_VERSION)"    >> $(TOOLCHAIN_PATH)/README
	@echo ""                                      >> $(TOOLCHAIN_PATH)/README
	@echo "-----------"                           >> $(TOOLCHAIN_PATH)/README
	@echo ""                                      >> $(TOOLCHAIN_PATH)/README
	@if [ -n "`cat $(build_dir)/bfd/bfdver.h | grep BFD_VERSION_STRING | cut -f4 -d'"'`" ] ; then \
	   version_string="`cat $(build_dir)/bfd/bfdver.h | grep BFD_VERSION_STRING | cut -f4 -d'"'`" ; \
	   echo "  binutils-$${version_string}" >> $(TOOLCHAIN_PATH)/README ; \
	 else \
	   echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README ; \
	 fi
	@touch $@
