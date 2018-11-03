
all: dist/bin/xd

dist/bin/xd: $(shell find sources/bash/source -type f -name '*.sh') sources/bash/Makefile sources/bash/config.mk
	@make -C sources/bash
	@mkdir -p $(shell dirname $@)
	@cp -vu sources/bash/build/xd dist/bin/xd

install:
	@cp -vu bin/xd /bin

uninstall:
	@rm -vrf /bin/xd

clean:
	@make -C sources/bash clean
	@rm -vrf dist

