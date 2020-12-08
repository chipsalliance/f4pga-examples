mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))
TOP := top
VERILOG := ${current_dir}/picosoc_noflash.v \
           ${current_dir}/picorv32.v \
           ${current_dir}/simpleuart.v \
           ${current_dir}/progmem.v
PARTNAME := xc7a35tcpg236-1
DEVICE  := xc7a50t_test
BITSTREAM_DEVICE := artix7
PCF := ${current_dir}/basys3.pcf
SDC := ${current_dir}/picosoc.sdc
BUILDDIR := build

ifeq ($(TARGET),arty_35)
  VERILOG += ${current_dir}/arty.v
  PARTNAME := xc7a35tcsg324-1
  PCF :=${current_dir}/arty.pcf
  BOARD_BUILDDIR := ${BUILDDIR}/arty_35
else ifeq ($(TARGET),arty_100)
  VERILOG += ${current_dir}/arty.v
  PARTNAME := xc7a100tcsg324-1
  PCF:=${current_dir}/arty.pcf
  DEVICE := xc7a100t_test
  BOARD_BUILDDIR := ${BUILDDIR}/arty_100
else
  VERILOG += ${current_dir}/basys3.v
  PARTNAME := xc7a35tcpg236-1
  PCF := ${current_dir}/basys3.pcf
  BOARD_BUILDDIR := ${BUILDDIR}/basys3
endif

all: ${BUILDDIR}/${TOP}.bit

${BUILDDIR}:
	mkdir ${BUILDDIR}

${BUILDDIR}/${TOP}.eblif: | ${BUILDDIR}
	cd ${BUILDDIR} && symbiflow_synth -t ${TOP} -v ${VERILOG} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.net: ${BUILDDIR}/${TOP}.eblif
	cd ${BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.place: ${BUILDDIR}/${TOP}.net
	cd ${BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} -p ${PCF} -n ${TOP}.net -P ${PARTNAME} -s ${SDC} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.route: ${BUILDDIR}/${TOP}.place
	cd ${BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.fasm: ${BUILDDIR}/${TOP}.route
	cd ${BUILDDIR} && symbiflow_write_fasm -e ${TOP}.eblif -d ${DEVICE}

${BUILDDIR}/${TOP}.bit: ${BUILDDIR}/${TOP}.fasm
	cd ${BUILDDIR} && symbiflow_write_bitstream -d ${BITSTREAM_DEVICE} -f ${TOP}.fasm -p ${PARTNAME} -b ${TOP}.bit

clean:
	rm -rf ${BUILDDIR}

