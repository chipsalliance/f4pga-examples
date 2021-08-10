export mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
export current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

export TOP := top
export SOURCES := ${current_dir}/counter.v

all:
	cd ../../common && $(MAKE)

clean:
	cd ../../common && $(MAKE) clean    

