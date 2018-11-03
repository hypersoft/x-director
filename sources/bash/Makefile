
include config.mk

all: $(PROJECT_PROGRAM)

$(BUILD_OUTPUT_DIR)/functions.lst: $(PROJECT_AUX_SCRIPTS)
	@mkdir -p $(BUILD_OUTPUT_DIRECTORIES)
	@cat $^ | grep -E '^function' | sed -E -e 's/\s*function\s+//g' -e 's/\s*\(.*//g' > $@

$(BUILD_OUTPUT_DIR)/options.sh: $(BUILD_OUTPUT_DIR)/functions.lst
	@printf "OPTIONS='\n%s\n';\n" "`grep -E -e '^-' $< `" > $@;

$(BUILD_OUTPUT_DIR)/functions.sh: $(BUILD_OUTPUT_DIR)/functions.lst
	@printf "FUNCTIONS='\n%s\n';\n" "`grep -E -v -e '^-' -e '\.' -e '^call' $<`" > $@;

$(PROJECT_AUX_SCRIPT): $(PROJECT_LIBRARY_SCRIPTS) $(PROJECT_AUX_SCRIPTS) $(PROJECT_AUTO_SCRIPTS) $(PROJECT_MAIN_SCRIPT)
	@mkdir -p $(BUILD_OUTPUT_DIRECTORIES)
	bin/compile $^ > $@

$(PROJECT_PROGRAM): $(PROJECT_AUX_SCRIPT) Makefile config.mk
	@mkdir -p `dirname $@`
	bin/link /bin/bash $< > $@
	chmod +x $@

export-program-dependency-files:
	@echo $(addprefix $(PREFIX)/,$(PROJECT_LIBRARY_SCRIPTS) $(PROJECT_AUX_SCRIPTS) $(PROJECT_MAIN_SCRIPT) Makefile config.mk);

export-program-name:
	@echo $(PROJECT_PROGRAM_NAME)

export-program-directory:
	@echo $(PREFIX)/$(BUILD_PROGRAM_DIR)

clean:
	@rm -vrf $(BUILD_OUTPUT_DIRECTORIES) $(PROJECT_PROGRAM)

