mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))
BUILDDIR_35  := build
BUILDDIR_100 := build_100

ifeq ($(TARGET), arty_100)
    BOARD    := "a7-100"
    BUILDDIR := ${BUILDDIR_100}
else
    BOARD   := "a7-35"
    BUILDDIR := ${BUILDDIR_35}
endif

all: ${BUILDDIR}/gateware/arty.bit

${BUILDDIR}/gateware/arty.bit:
	python3 generate.py \
		--build \
		--board ${BOARD} \
		--builddir ${BUILDDIR}

clean:
	-rm -rf ${BUILDDIR_100} ${BUILDDIR_35}

.PHONY: all clean load
