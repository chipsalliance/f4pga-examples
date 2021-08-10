current_dir := ${CURDIR}
TOP := top
SOURCES := ${current_dir}/baselitex_arty.v \
           ${current_dir}/VexRiscv_Linux.v
MEM_INIT := ${current_dir}/mem.init \
            ${current_dir}/mem_1.init \
            ${current_dir}/mem_2.init
PCF := ${current_dir}/arty.pcf
SDC := ${current_dir}/arty.sdc
XDC := ${current_dir}/arty.xdc


BITSTREAM_DEVICE := artix7

ifeq ($(TARGET),arty_100)
    PARTNAME := xc7a100tcsg324-1
    DEVICE   := xc7a100t_test
else
    PARTNAME := xc7a35tcsg324-1
    DEVICE   := xc7a50t_test
endif

export

all:
	cd ../../common && $(MAKE)

clean:
	cd ../../common && $(MAKE) clean    