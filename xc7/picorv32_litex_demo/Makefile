mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))
TOP := arty
VERILOG := ${current_dir}/picorv32.v \
           ${current_dir}/arty.v
MEM_INIT := ${current_dir}/mem_2.init \
            ${current_dir}/mem_1.init \
            ${current_dir}/mem.init
BITSTREAM_DEVICE := artix7
SDC := ${current_dir}/arty.sdc
XDC := ${current_dir}/arty.xdc
BUILDDIR := build

ifeq ($(TARGET),arty_100)
    PARTNAME := xc7a100tcsg324-1
    DEVICE   := xc7a100t_test
    BOARD_BUILDDIR := ${BUILDDIR}/arty_100
else
    PARTNAME := xc7a35tcsg324-1
    DEVICE   := xc7a50t_test
    BOARD_BUILDDIR := ${BUILDDIR}/arty_35
endif

all: ${BOARD_BUILDDIR}/${TOP}.bit

${BOARD_BUILDDIR}:
	mkdir -p ${BOARD_BUILDDIR}
	ln -s ${MEM_INIT} ${BOARD_BUILDDIR}

${BOARD_BUILDDIR}/${TOP}.eblif: | ${BOARD_BUILDDIR}
	cd ${BOARD_BUILDDIR} && symbiflow_synth -t ${TOP} -v ${VERILOG} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} -x ${XDC} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.net: ${BOARD_BUILDDIR}/${TOP}.eblif
	cd ${BOARD_BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.place: ${BOARD_BUILDDIR}/${TOP}.net
	cd ${BOARD_BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} -n ${TOP}.net -P ${PARTNAME} -s ${SDC} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.route: ${BOARD_BUILDDIR}/${TOP}.place
	cd ${BOARD_BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.fasm: ${BOARD_BUILDDIR}/${TOP}.route
	cd ${BOARD_BUILDDIR} && symbiflow_write_fasm -e ${TOP}.eblif -d ${DEVICE}

${BOARD_BUILDDIR}/${TOP}.bit: ${BOARD_BUILDDIR}/${TOP}.fasm
	cd ${BOARD_BUILDDIR} && symbiflow_write_bitstream -d ${BITSTREAM_DEVICE} -f ${TOP}.fasm -p ${PARTNAME} -b ${TOP}.bit

clean:
	rm -rf ${BUILDDIR}
