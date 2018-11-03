
$(XD_PROGRAM): $(XD_DEPENDENCIES)
	@$(XD_MAKE)

install:
	@INSTALLATION_MODE=1 make

uninstall:
	@INSTALLATION_MODE=1 make $@

clean-xd-package:
	@$(XD_MAKE) clean

clean: clean-xd-package clean-dist

$(XD_PROGRAM_DIST): $(XD_PROGRAM)
	@mkdir -p $(shell dirname $(XD_PROGRAM_DIST))
	@cp -vu $< $@

clean-dist:
	@rm -vrf $(PACKAGE_DIST_BIN)
