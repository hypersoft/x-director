$(XD_PROGRAM_DIST): $(XD_PROGRAM)
	@cp -vu $< $@

uninstall:
	@rm -v $(XD_PROGRAM_DIST)
