
ifndef BUILD_PROGRAM_DIR
BUILD_PROGRAM_DIR := bin
endif

BUILD_OUTPUT_DIR = build
BUILD_SOURCE_DIR = source

BUILD_OUTPUT_DIRECTORIES = $(BUILD_OUTPUT_DIR)

PROJECT_AUX_DIRS != echo $(BUILD_SOURCE_DIR)/{environment.d,functions.d,shortcuts.d}

PROJECT_AUX_SCRIPTS != find $(PROJECT_AUX_DIRS) -maxdepth 1 -type f -name '*.sh';

PROJECT_AUX_SCRIPT = $(BUILD_OUTPUT_DIR)/xd.o

PROJECT_AUTO_SCRIPTS = $(addprefix $(BUILD_OUTPUT_DIR)/,options.sh functions.sh)

PROJECT_LIBRARY_SCRIPTS != find $(BUILD_SOURCE_DIR)/libraries.d -maxdepth 1 -type f -name '*.sh';

PROJECT_MAIN_SCRIPT = $(BUILD_SOURCE_DIR)/main.sh

PROJECT_PROGRAM = $(BUILD_PROGRAM_DIR)/xd
