

COMPONENT_TARGETS  = $(TOOLCHAIN_S8XX_NEWLIB)


FLAVOURS = static full


include ../../../build-system/config.mk


SOURCE_REQUIRES  = sources/gcc
SOURCE_REQUIRES += sources/GNU/gmp
SOURCE_REQUIRES += sources/GNU/mpfr
SOURCE_REQUIRES += sources/GNU/mpc


ifneq ($(findstring newlib, $(TOOLCHAIN)),)
ifeq ($(FLAVOUR),static)
REQUIRES  = core/newlib/2016.09.17^headers
endif
ifeq ($(FLAVOUR),full)
REQUIRES  = core/newlib/2016.09.17^full
endif
endif


# ======= __END_OF_REQUIRES__ =======

tar_xz_archive        = $(SRC_PACKAGE_PATH)/gcc/gcc-arc-2016.09.17.tar.xz
tar_xz_archive_gmp    = $(SRC_PACKAGE_PATH)/GNU/gmp/gmp-6.1.0.tar.xz
tar_xz_archive_mpfr   = $(SRC_PACKAGE_PATH)/GNU/mpfr/mpfr-3.1.3.tar.xz
tar_gz_archive_mpc    = $(SRC_PACKAGE_PATH)/GNU/mpc/mpc-1.0.3.tar.gz
SRC_ARCHIVE           = $(tar_xz_archive)
SRC_DIR               = $(TARGET_BUILD_DIR)/gcc-arc-2016.09.17
src_dir_name          = gcc-arc-2016.09.17
src_done              = $(TARGET_BUILD_DIR)/.source-done
gmp_src_done          = $(TARGET_BUILD_DIR)/.gmp-source-done
mpfr_src_done         = $(TARGET_BUILD_DIR)/.mpfr-source-done
mpc_src_done          = $(TARGET_BUILD_DIR)/.mpc-source-done

PATCHES = PATCHES

build_dir             = $(TARGET_BUILD_DIR)/build

sysroot_dir           = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

static_build_target   = $(TARGET_BUILD_DIR)/.static-built
static_install_target = $(TARGET_BUILD_DIR)/.static-installed
full_build_target     = $(TARGET_BUILD_DIR)/.full-built
full_install_target   = $(TARGET_BUILD_DIR)/.full-installed


LIBSUFFIX    =


ifeq ($(FLAVOUR),static)
BUILD_TARGETS  = $(static_build_target)
BUILD_TARGETS += $(static_install_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS  = $(full_build_target)
BUILD_TARGETS += $(full_install_target)
endif


include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_NEWLIB))
extra_configure_switches  = --with-cpu=arcem
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-endian=little
extra_configure_switches += --disable-werror
ifeq ($(FLAVOUR),static)
extra_configure_switches += --enable-languages=c
else
extra_configure_switches += --enable-languages=c,c++
extra_configure_switches += --with-newlib
endif
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(gmp_src_done): $(src_done)
	@echo "Expanding $(tar_xz_archive_gmp)"
	@tar xJf $(tar_xz_archive_gmp) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../gmp-6.1.0 gmp
	@touch $@

$(mpfr_src_done): $(src_done)
	@echo "Expanding $(tar_xz_archive_mpfr)"
	@tar xJf $(tar_xz_archive_mpfr) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpfr-3.1.3 mpfr
	@touch $@

$(mpc_src_done): $(src_done)
	@echo "Expanding $(tar_gz_archive_mpc)"
	@tar xzf $(tar_gz_archive_mpc) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpc-1.0.3 mpc
	@touch $@

$(static_build_target): $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --with-as=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as \
	  --with-ld=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	@$(environment) $(MAKE) -C $(build_dir) all-{gcc,target-libgcc}
	@touch $@

$(static_install_target): $(static_build_target)
	@$(MAKE) $(environment) -j1 -C $(build_dir) install-{gcc,target-libgcc}
	@( major="`cat $(build_dir)/gcc/bversion.h | grep '#define BUILDING_GCC_MAJOR' | cut -f3 -d' '`"      ; \
	   minor="`cat $(build_dir)/gcc/bversion.h | grep '#define BUILDING_GCC_MINOR' | cut -f3 -d' '`"      ; \
	   patch="`cat $(build_dir)/gcc/bversion.h | grep '#define BUILDING_GCC_PATCHLEVEL' | cut -f3 -d' '`" ; \
	   version_string="$${major}.$${minor}.$${patch}" ; \
	   if [ -n "$${version_string}" ] ; then \
	     echo "  gcc-$${version_string}$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README ; \
	   else \
	     echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README ; \
	   fi ; \
	 )
	@touch $@


$(full_build_target): $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done)
	@mkdir -p $(build_dir)
	cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --with-as=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as \
	  --with-ld=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	@$(environment) $(MAKE) -C $(build_dir) all-{gcc,target-libgcc,target-libstdc++-v3}
	@touch $@

$(full_install_target): $(full_build_target)
	@$(MAKE) $(environment) -j1 -C $(build_dir) pdf-gcc
	@$(MAKE) $(environment) -j1 -C $(build_dir) install-{gcc,target-libgcc,target-libstdc++-v3,pdf-gcc}
	@( cd $(TOOLCHAIN_PATH)/$(TARGET)/lib$(LIBSUFFIX) ; \
	   sed -i 's,-L.*\.libs,-L$(TOOLCHAIN_PATH)/$(TARGET)/lib$(LIBSUFFIX),g' libstdc++.la libsupc++.la ; \
	 )
	@( major="`cat $(build_dir)/gcc/bversion.h | grep '#define BUILDING_GCC_MAJOR' | cut -f3 -d' '`"      ; \
	   minor="`cat $(build_dir)/gcc/bversion.h | grep '#define BUILDING_GCC_MINOR' | cut -f3 -d' '`"      ; \
	   patch="`cat $(build_dir)/gcc/bversion.h | grep '#define BUILDING_GCC_PATCHLEVEL' | cut -f3 -d' '`" ; \
	   version_string="$${major}.$${minor}.$${patch}" ; \
	   if [ -n "$${version_string}" ] ; then \
	     echo "  gcc-$${version_string}$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README ; \
	   else \
	     echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README ; \
	   fi ; \
	 )
	@touch $@
