
COMPONENT_TARGETS = $(TOOLCHAIN_HOST)


include config.mk


# ======= __END_OF_REQUIRES__ =======


config_makefile = targets-config.mk


CLEANUP_FILES += $(config_makefile)


BUILD_TARGETS = $(config_makefile)

# CORE Makefile:

include core.mk

# Dependencies:

$(config_makefile): $(config_makefile).template
	@echo "Creating $(config_makefile) ..."
	@cp $(config_makefile).template $@
