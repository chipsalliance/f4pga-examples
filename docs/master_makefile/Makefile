# This is the master Makefile for all projects
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))
TOP := top
VERILOG := ${current_dir}/*.v
DEVICE  := xc7a50t_test
BITSTREAM_DEVICE := artix7
BUILDDIR:=build

ifeq ($(TARGET),arty_35)
  PARTNAME := xc7a35tcsg324-1
  BOARD_BUILDDIR := ${BUILDDIR}/arty_35
else ifeq ($(TARGET),arty_100)
  PARTNAME:= xc7a100tcsg324-1
  DEVICE:= xc7a100t_test
  BOARD_BUILDDIR := ${BUILDDIR}/arty_100
else ifeq ($(TARGET),nexys4ddr)
  PARTNAME:= xc7a100tcsg324-1
  DEVICE:= xc7a100t_test
  BOARD_BUILDDIR := ${BUILDDIR}/nexys4ddr
else ifeq ($(TARGET),zybo)
  PARTNAME:= xc7z010clg400-1
  DEVICE:= xc7z010_test
  BITSTREAM_DEVICE:= zynq7
  BOARD_BUILDDIR := ${BUILDDIR}/zybo
  VERILOG:=${current_dir}/*.v
else ifeq ($(TARGET),nexys_video)
  PARTNAME:= xc7a200tsbg484-1
  DEVICE:= xc7a200t_test
  BOARD_BUILDDIR := ${BUILDDIR}/nexys_video
else
  PARTNAME:= xc7a35tcpg236-1
  BOARD_BUILDDIR := ${BUILDDIR}/basys3
endif

XDC:=${current_dir}/*.xdc

.DELETE_ON_ERROR:


all: ${BOARD_BUILDDIR}/${TOP}.bit

${BOARD_BUILDDIR}:
	mkdir -p ${BOARD_BUILDDIR}

${BOARD_BUILDDIR}/${TOP}.eblif: | ${BOARD_BUILDDIR}
	cd ${BOARD_BUILDDIR} && symbiflow_synth -t ${TOP} -v ${VERILOG} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} -x ${XDC} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.net: ${BOARD_BUILDDIR}/${TOP}.eblif
	cd ${BOARD_BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.place: ${BOARD_BUILDDIR}/${TOP}.net
	cd ${BOARD_BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} -n ${TOP}.net -P ${PARTNAME} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.route: ${BOARD_BUILDDIR}/${TOP}.place
	cd ${BOARD_BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.fasm: ${BOARD_BUILDDIR}/${TOP}.route
	cd ${BOARD_BUILDDIR} && symbiflow_write_fasm -e ${TOP}.eblif -d ${DEVICE}

${BOARD_BUILDDIR}/${TOP}.bit: ${BOARD_BUILDDIR}/${TOP}.fasm
	cd ${BOARD_BUILDDIR} && symbiflow_write_bitstream -d ${BITSTREAM_DEVICE} -f ${TOP}.fasm -p ${PARTNAME} -b ${TOP}.bit

clean:
	rm -rf ${BUILDDIR}
