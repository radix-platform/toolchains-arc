# include once
ifndef CONFIG_MK

#######
####### Constants:
#######


DOWNLOAD_SERVER      = ftp://ftp.radix.pro

WGET_OPTIONS         = -q -N

CACHED_CC_OUTPUT     = /opt/extra/ccache

TOOLCHAINS_BASE_PATH = /opt/toolchains

TOOLCHAINS_VERSION   = 1.0.0


# Build machine architrcture:

BUILD_ARCH = x86_64-pc-linux-gnu
#
# HOST and BUILD variables should be set up for each makefile.
# NOTE: the HOST is equal to BUILD because our toolchains work on BUILD machine.
#
 HOST = $(BUILD_ARCH)
BUILD = $(BUILD_ARCH)


#######
####### Standard Available Toolchains:
#######

#
# NOTE:
# ====
#   Toolchain names defined by 'TOOLCHAIN_...' variables.
#   Configuration variable names such as HOST_ARCH, HOST_DIR, HOST_PATH should have prefix
#   which is equal to $(TOOLCHAIN_...) in upper case letters and symbol '-' should be replaced with '_'.
#   In other words the PREFIX is equal to PREFIX = $(shell echo $(TOOLCHAIN_...) | tr '[a-z-]' '[A-Z_]').
#

# NOARCH
TOOLCHAIN_NOARCH = noarch

NOARCH_ARCH = noarch
NOARCH_DIR  = noarch
NOARCH_PATH = $(TOOLCHAINS_BASE_PATH)/noarch


# HOST
TOOLCHAIN_HOST = host

HOST_ARCH = $(BUILD_ARCH)
HOST_DIR  = $(word 1, $(subst -, ,$(BUILD_ARCH)))
HOST_PATH = $(TOOLCHAINS_BASE_PATH)/$(HOST_DIR)


#######
####### Additional Available Toolchains:
#######

# Amlogic S8XX
TOOLCHAIN_S8XX_NEWLIB = s8xx-newlib

S8XX_NEWLIB_ARCH = arc-s8xx-elf32
S8XX_NEWLIB_DIR  = arc-S8XX-elf32-newlib
S8XX_NEWLIB_PATH = $(TOOLCHAINS_BASE_PATH)/$(S8XX_NEWLIB_DIR)



CONFIG_MK=1
endif
