

COMPONENT_TARGETS  = $(TOOLCHAIN_S8XX_NEWLIB)


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/binutils

REQUIRES  = core/gcc/2016.09.17^full

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive   = $(SRC_PACKAGE_PATH)/binutils/binutils-gdb-arc-2016.09.17.tar.xz
SRC_ARCHIVE      = $(tar_xz_archive)
SRC_DIR          = $(TARGET_BUILD_DIR)/binutils-gdb-arc-2016.09.17
src_dir_name     = binutils-gdb-arc-2016.09.17
src_done         = $(SRC_DIR)/.source-done

build_dir        = $(TARGET_BUILD_DIR)/build

build_target     = $(TARGET_BUILD_DIR)/.built
install_target   = $(TARGET_BUILD_DIR)/.installed

environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)


BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(install_target)

include ../../../build-system/core.mk



ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_NEWLIB))
extra_configure_switches  = --with-cpu=arcem
extra_configure_switches += --with-endian=little
extra_configure_switches += --disable-multilib
extra_configure_switches += --disable-werror
extra_configure_switches += --enable-languages=c,c++
endif


$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_target): $(src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)              \
	  --target=$(TARGET)                      \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	@$(MAKE) $(environment) -C $(build_dir) all-{gdb,sim}
	@touch $@

$(install_target): $(build_target)
	@$(MAKE) $(environment) -j1 -C $(build_dir) install-{gdb,sim}
	@( version_string="`cat $(SRC_DIR)/gdb/version.in | cut -f1,2,3 -d'.'`" ; \
	   if [ -n "$${version_string}" ] ; then \
	     echo "gdb-$${version_string}" >> $(TOOLCHAIN_PATH)/components.txt ; \
	   else \
	     echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt ; \
	   fi ; \
	 )
	@touch $@
