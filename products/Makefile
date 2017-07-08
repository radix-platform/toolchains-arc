

COMPONENT_TARGETS  = $(TOOLCHAIN_S8XX_NEWLIB)


export TOOLCHAIN_VERSION = 1.3.0


include ../build-system/config.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_NEWLIB))
REQUIRES  = products/S8XX-newlib/1.3.0
endif

# ======= __END_OF_REQUIRES__ =======


install_target     = $(TARGET_BUILD_DIR)/.install_done

BUILD_TARGETS      = $(install_target)


include ../build-system/core.mk


$(install_target):
	@touch $@
