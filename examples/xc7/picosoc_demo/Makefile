mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))
TOP := basys3_demo
VERILOG := ${current_dir}/basys3_demo_no_roi.v \
           ${current_dir}/picosoc_noflash.v \
           ${current_dir}/picorv32.v \
           ${current_dir}/simpleuart.v \
           ${current_dir}/progmem.v
PARTNAME := xc7a35tcpg236-1
DEVICE  := xc7a50t_test
BITSTREAM_DEVICE := artix7
PCF := ${current_dir}/basys3.pcf
SDC := ${current_dir}/basys3.sdc
BUILDDIR := build

all: ${BUILDDIR}/${TOP}.bit

${BUILDDIR}:
	mkdir ${BUILDDIR}

${BUILDDIR}/${TOP}.eblif: | ${BUILDDIR}
	cd ${BUILDDIR} && synth -t ${TOP} -v ${VERILOG} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.net: ${BUILDDIR}/${TOP}.eblif
	cd ${BUILDDIR} && pack -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.place: ${BUILDDIR}/${TOP}.net
	cd ${BUILDDIR} && place -e ${TOP}.eblif -d ${DEVICE} -p ${PCF} -n ${TOP}.net -P ${PARTNAME} -s ${SDC} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.route: ${BUILDDIR}/${TOP}.place
	cd ${BUILDDIR} && route -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.fasm: ${BUILDDIR}/${TOP}.route
	cd ${BUILDDIR} && write_fasm -e ${TOP}.eblif -d ${DEVICE}

${BUILDDIR}/${TOP}.bit: ${BUILDDIR}/${TOP}.fasm
	cd ${BUILDDIR} && write_bitstream -d ${BITSTREAM_DEVICE} -f ${TOP}.fasm -p ${PARTNAME} -b ${TOP}.bit

clean:
	rm -rf ${BUILDDIR}

