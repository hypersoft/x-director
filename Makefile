
MAKEFLAGS = --no-print-directory

XD_PACKAGE = sources/bash

XD_MAKE := PACKAGE_PREFIX=$(XD_PACKAGE) make $(MAKEFLAGS) -f $(XD_PACKAGE)/Makefile

XD_DEPENDENCIES != $(XD_MAKE) export-program-dependency-files
XD_PROGRAM_NAME != $(XD_MAKE) export-program-name
XD_PROGRAM_DIR != $(XD_MAKE) export-program-directory

ifdef INSTALLATION_MODE
PACKAGE_DIST = /usr
else
PACKAGE_DIST = dist
endif

PACKAGE_DIST_BIN = $(PACKAGE_DIST)/bin
PACKAGE_DIST_LIB = $(PACKAGE_DIST)/lib
PACKAGE_DIST_INC = $(PACKAGE_DIST)/include

XD_PROGRAM_DIST = $(PACKAGE_DIST_BIN)/$(XD_PROGRAM_NAME)

XD_PROGRAM = $(XD_PROGRAM_DIR)/$(XD_PROGRAM_NAME)

all: $(XD_PROGRAM_DIST)

ifdef INSTALLATION_MODE
include configuration/install.mk
else
include configuration/build.mk
endif

.PHONY: clean clean-xd-package clean-dist uninstall install all