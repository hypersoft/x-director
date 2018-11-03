
XD_DEPENDENCIES != make --no-print-directory -C sources/bash build-dependency-list
XD_PROGRAM != make --no-print-directory -C sources/bash build-program-file

all: program

program: $(XD_PROGRAM)

$(XD_PROGRAM): $(XD_DEPENDENCIES)
	@make --no-print-directory -C sources/bash

dist/bin/xd: $(XD_PROGRAM)
	@mkdir -p $(shell dirname $@)
	@cp -vu $< $@

install:
	@cp -vu dist/bin/xd /bin

uninstall:
	@rm -vrf /bin/xd

clean:
	@make --no-print-directory -C sources/bash clean
	@rm -vrf dist

