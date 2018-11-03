
all: bin/xd

export BUILD_PROGRAM_DIR=../../bin

bin/xd: $(shell find sources/bash/source -type f -name '*.sh')
	@make -C sources/bash 

install:
	@cp -vu bin/xd /bin

uninstall:
	@rm -vrf /bin/xd

clean:
	@make -C sources/bash clean