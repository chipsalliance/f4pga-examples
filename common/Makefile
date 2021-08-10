BUILDDIR := ${current_dir}/build

# Set board properties based on TARGET variable
ifeq ($(TARGET),arty_35)
  DEVICE := xc7a50t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a35tcsg324-1
  CONSTRAINT_PATH := ${current_dir}/arty
  BOARD_BUILDDIR := ${BUILDDIR}/arty_35
else ifeq ($(TARGET),arty_100)
  DEVICE := xc7a100t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a100tcsg324-1
  CONSTRAINT_PATH := ${current_dir}/arty
  BOARD_BUILDDIR := ${BUILDDIR}/arty_100
else ifeq ($(TARGET),nexys4ddr)
  DEVICE := xc7a100t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a100tcsg324-1
  CONSTRAINT_PATH := ${current_dir}/nexys4ddr
  BOARD_BUILDDIR := ${BUILDDIR}/nexys4ddr
else ifeq ($(TARGET),zybo)
  DEVICE := xc7z010_test
  BITSTREAM_DEVICE := zynq7
  PARTNAME := xc7z010clg400-1
  CONSTRAINT_PATH := ${current_dir}/zybo
  BOARD_BUILDDIR := ${BUILDDIR}/zybo
  SOURCES := ${current_dir}/counter_zynq.v
else ifeq ($(TARGET),nexys_video)
  DEVICE := xc7a200t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a200tsbg484-1
  CONSTRAINT_PATH := ${current_dir}/nexys_video
  BOARD_BUILDDIR := ${BUILDDIR}/nexys_video
else
  DEVICE := xc7a50t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a35tcpg236-1
  CONSTRAINT_PATH := ${current_dir}/basys3
  BOARD_BUILDDIR := ${BUILDDIR}/basys3
endif

# Determine the type of constraint being used
ifneq ($(wildcard ${CONSTRAINT_PATH}.xdc),)
  XDC_CMD := -x ${CONSTRAINT_PATH}.xdc
endif
ifneq ($(wildcard ${CONSTRAINT_PATH}.sdc),)
  SDC_CMD := -s ${CONSTRAINT_PATH}.sdc
endif
ifneq ($(wildcard ${CONSTRAINT_PATH}.pcf),)
  PCF_CMD := -p ${CONSTRAINT_PATH}.pcf
endif

.DELETE_ON_ERROR:

# Build design
all: ${BOARD_BUILDDIR}/${TOP}.bit

${BOARD_BUILDDIR}:
	mkdir -p ${BOARD_BUILDDIR}
  #Check if design includes initialization files for memory
  ifneq (${MEM_INIT},)
    #if there are memory initialization files link them to the build/board_type directory
	  ln -s ${MEM_INIT} ${BOARD_BUILDDIR}
  endif

${BOARD_BUILDDIR}/${TOP}.eblif: | ${BOARD_BUILDDIR}
	cd ${BOARD_BUILDDIR} && symbiflow_synth -t ${TOP} -v ${SOURCES} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} ${XDC_CMD} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.net: ${BOARD_BUILDDIR}/${TOP}.eblif
	cd ${BOARD_BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} ${SDC_CMD} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.place: ${BOARD_BUILDDIR}/${TOP}.net
	cd ${BOARD_BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} ${PCF_CMD} -n ${TOP}.net -P ${PARTNAME} ${SDC_CMD} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.route: ${BOARD_BUILDDIR}/${TOP}.place
	cd ${BOARD_BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} ${SDC_CMD} 2>&1 > /dev/null

${BOARD_BUILDDIR}/${TOP}.fasm: ${BOARD_BUILDDIR}/${TOP}.route
	cd ${BOARD_BUILDDIR} && symbiflow_write_fasm -e ${TOP}.eblif -d ${DEVICE}

${BOARD_BUILDDIR}/${TOP}.bit: ${BOARD_BUILDDIR}/${TOP}.fasm
	cd ${BOARD_BUILDDIR} && symbiflow_write_bitstream -d ${BITSTREAM_DEVICE} -f ${TOP}.fasm -p ${PARTNAME} -b ${TOP}.bit

clean:
	rm -rf ${BUILDDIR}