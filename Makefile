
MAKEFLAGS = --no-print-directory

XD_PACKAGE = sources/bash

XD_MAKE = make --no-print-directory -C $(XD_PACKAGE)

XD_DEPENDENCIES != $(XD_MAKE) export-program-dependency-files
XD_PROGRAM_NAME != $(XD_MAKE) export-program-name
XD_PROGRAM_DIR != $(XD_MAKE) export-program-directory

XD_PROGRAM_DIST = dist/bin/$(XD_PROGRAM_NAME)

XD_PROGRAM = $(XD_PACKAGE)/$(XD_PROGRAM_DIR)/$(XD_PROGRAM_NAME)

all: $(XD_PROGRAM_DIST)

$(XD_PROGRAM): $(addprefix $(XD_PACKAGE)/,$(XD_DEPENDENCIES))
	@$(XD_MAKE)

$(XD_PROGRAM_DIST): $(XD_PROGRAM)
	@mkdir -p $(shell dirname $@)
	@cp -vu $< $@

install:
	@cp -vu $(XD_PROGRAM_DIST) /bin

uninstall:
	@rm -vrf /bin/$(XD_PROGRAM_NAME)

clean:
	@$(XD_MAKE) clean
	@rm -vrf dist

