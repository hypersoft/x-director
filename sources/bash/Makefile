ifndef PACKAGE_PREFIX
PACKAGE_PREFIX = .
endif

include $(PACKAGE_PREFIX)/config.mk

all: $(PROJECT_PROGRAM)

$(PROJECT_OUTPUT_DIR)/functions.lst: $(PROJECT_AUX_SCRIPTS) $(PROJECT_HELP_SCRIPT)
	$(PACKAGE_PREFIX)/bin/list-script-functions $^ > $@

$(PROJECT_OUTPUT_DIR)/options.sh: $(PROJECT_OUTPUT_DIR)/functions.lst
	@printf "declare OPTIONS='\n%s\n';\n" "`grep -E -e '^-' $< `" > $@;

$(PROJECT_OUTPUT_DIR)/functions.sh: $(PROJECT_OUTPUT_DIR)/functions.lst
	@printf "declare FUNCTIONS='\n%s\n';\n" "`grep -E -v -e '^-' -e '\.' -e '^call' $<`" > $@;

$(PROJECT_AUX_SCRIPT): $(PROJECT_LIBRARY_SCRIPTS) $(PROJECT_AUX_SCRIPTS) $(PROJECT_AUTO_SCRIPTS) $(PROJECT_MAIN_SCRIPT)
	@mkdir -p $(PROJECT_OUTPUT_DIRECTORIES)
	$(PACKAGE_PREFIX)/bin/compile $^ > $@

$(PROJECT_PROGRAM): $(PROJECT_AUX_SCRIPT) $(PACKAGE_PREFIX)/Makefile $(PACKAGE_PREFIX)/config.mk
	@mkdir -p `dirname $@`
	$(PACKAGE_PREFIX)/bin/link $(PROJECT_SCRIPT_INTERPRETER) $< > $@
	chmod +x $@

$(PROJECT_HELP_SCRIPT): $(shell echo $(PROJECT_HELP_SOURCE_DIR)/text.d/*) $(shell echo $(PROJECT_HELP_SOURCE_DIR)/*.txt)
	@mkdir -p $(PROJECT_OUTPUT_DIRECTORIES)
	$(PROJECT_HELP_SOURCE_DIR)/help.auto.sh > $@

export-program-dependency-files:
	@echo $(PROJECT_LIBRARY_SCRIPTS) $(PROJECT_AUX_SCRIPTS) $(PROJECT_MAIN_SCRIPT) $(PACKAGE_PREFIX)/Makefile $(PACKAGE_PREFIX)/config.mk

export-program-name:
	@echo $(PROJECT_PROGRAM_NAME)

export-program-directory:
	@echo $(PROJECT_PROGRAM_DIR)

clean:
	@rm -vrf $(PROJECT_OUTPUT_DIRECTORIES) $(PROJECT_PROGRAM)
