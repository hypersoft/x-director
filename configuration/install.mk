$(XD_PROGRAM_DIST): $(XD_PROGRAM_LOCAL)
	@cp -vu $< $@

uninstall:
	@rm -v $(XD_PROGRAM_DIST)
