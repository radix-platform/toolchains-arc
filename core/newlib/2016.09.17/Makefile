
NO_PARALLEL = true

COMPONENT_TARGETS  = $(TOOLCHAIN_S8XX_NEWLIB)

FLAVOURS = headers full


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/newlib

ifeq ($(FLAVOUR),headers)
REQUIRES  = core/binutils/2016.09.17
endif
ifeq ($(FLAVOUR),full)
REQUIRES  = core/gcc/2016.09.17^static
endif

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/newlib/newlib-arc-2016.09.17.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/newlib-arc-2016.09.17
src_dir_name    = newlib-arc-2016.09.17
src_done        = $(TARGET_BUILD_DIR)/.source-done

PATCHES       = PATCHES

build_dir       = $(TARGET_BUILD_DIR)/build

install_dir         = $(TOOLCHAIN_PATH)
headers_install_dir = $(TOOLCHAIN_PATH)/$(TARGET)

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

build_target    = $(TARGET_BUILD_DIR)/.built
full_target     = $(TARGET_BUILD_DIR)/.installed



ifeq ($(FLAVOUR),headers)
BUILD_TARGETS  = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(full_target)
endif

include ../../../build-system/core.mk


environment  = AS="$(TOOLCHAIN_PATH)/bin/$(TARGET)-as"
environment += LD="$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld"
environment += CC="$(CCACHE)$(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc"
environment += AR="$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar"
environment += RANLIB="$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib"

environment += PATH_FIG2DEV="/usr/bin:/usr/X11R6/bin:/usr/share/texmf/bin"
environment += PATH="$(TOOLCHAIN_PATH)/bin:$(PATH):$(PATH_FIG2DEV)"
#                                                   =============
# need for fig2dev and documentation (see: ../.config).

environment += BUILD_CC="$(CCACHE)/usr/bin/gcc"
environment += TARGET_CFLAGS=""


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_NEWLIB))
extra_configure_switches  = --disable-multilib
extra_configure_switches += --with-cpu=arcem
extra_configure_switches += --with-endian=little

extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --enable-newlib-supplied-sycalls
# extra_configure_switches += --enable-newlib-global-atexit

extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(headers_target): $(src_done)
	@mkdir -p $(headers_install_dir)
	@cp -ar $(TARGET_BUILD_DIR)/$(src_dir_name)/newlib/libc/include $(headers_install_dir)/sys-include
	@if [ -n "`cat $(SRC_DIR)/newlib/configure | grep _NEWLIB_VERSION | cut -f3 -d'"' | sed 's,[^0-9.],,g'`" ] ; then \
	   version_string="`cat $(SRC_DIR)/newlib/configure | grep _NEWLIB_VERSION | cut -f3 -d'"' | sed 's,[^0-9.],,g'`" ; \
	   echo "  newlib-$${version_string}$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README ; \
	 else \
	   echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README ; \
	 fi
	@touch $@

$(build_target): $(src_done)
	# =======  Building newlib =======
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/newlib/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(BUILD)                 \
	  --host=$(TARGET)                 \
	  --target=$(TARGET)               \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  $(extra_configure_switches)
	@$(environment) $(MAKE) -C $(build_dir) all
	# =======  Building libgloss =======
	@mkdir -p $(build_dir)/libgloss
	@cd $(build_dir)/libgloss && $(environment) ../../$(src_dir_name)/libgloss/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(BUILD)                 \
	  --host=$(TARGET)                 \
	  --target=$(TARGET)               \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  $(extra_configure_switches)
	@$(environment) $(MAKE) -C $(build_dir)/libgloss all info
	@touch $@

$(full_target): $(build_target)
	@mkdir -p $(install_dir)
	@$(environment) $(MAKE) -C $(build_dir) install
	@$(environment) $(MAKE) -C $(build_dir)/libgloss install
	@$(environment) $(MAKE) -C $(build_dir) pdf
	@$(environment) $(MAKE) -C $(build_dir)/libgloss pdf
	# ======= Install Documentation =======
	@$(environment) $(MAKE) -C $(build_dir)/libgloss/doc install-info
	@mkdir -p $(TOOLCHAIN_PATH)/share/doc/newlib
	@cp $(build_dir)/libc/libc.pdf            $(TOOLCHAIN_PATH)/share/doc/newlib
	@cp $(build_dir)/libm/libm.pdf            $(TOOLCHAIN_PATH)/share/doc/newlib
	@cp $(build_dir)/libgloss/doc/porting.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
	@if [ -n "`cat $(SRC_DIR)/newlib/configure | grep _NEWLIB_VERSION | cut -f3 -d'"' | sed 's,[^0-9.],,g'`" ] ; then \
	   version_string="`cat $(SRC_DIR)/newlib/configure | grep _NEWLIB_VERSION | cut -f3 -d'"' | sed 's,[^0-9.],,g'`" ; \
	   echo "  newlib-$${version_string}$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README ; \
	 else \
	   echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README ; \
	 fi
	@touch $@
