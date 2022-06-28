TOP := $(strip ${TOP})
TARGET := $(strip ${TARGET})

BUILDDIR := ${current_dir}/build
BOARD_BUILDDIR := ${BUILDDIR}/${TARGET}

# Set board properties based on TARGET variable
ifeq ($(TARGET),arty_35)
  DEVICE := xc7a50t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a35tcsg324-1
  OFL_BOARD := arty_a7_35t
else ifeq ($(TARGET),arty_100)
  DEVICE := xc7a100t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a100tcsg324-1
  OFL_BOARD := arty_a7_100t
else ifeq ($(TARGET),nexys4ddr)
  DEVICE := xc7a100t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a100tcsg324-1
  OFL_BOARD := unsupported
else ifeq ($(TARGET),zybo)
  DEVICE := xc7z010_test
  BITSTREAM_DEVICE := zynq7
  PARTNAME := xc7z010clg400-1
  OFL_BOARD := zybo_z7_10
else ifeq ($(TARGET),nexys_video)
  DEVICE := xc7a200t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a200tsbg484-1
  OFL_BOARD := nexysVideo
else ifeq ($(TARGET),basys3)
  DEVICE := xc7a50t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a35tcpg236-1
  OFL_BOARD := $(TARGET)
else
  $(error Unsupported board type)
endif

# Determine the type of constraint being used
ifneq (${XDC},)
  XDC_CMD := -x ${XDC}
endif
ifneq (${SDC},)
  SDC_CMD := -s ${SDC}
endif
ifneq (${PCF},)
  PCF_CMD := -p ${PCF}
endif

# Determine if we should use Surelog/UHDM to read sources
ifneq (${SURELOG_CMD},)
  SURELOG_OPT := -s ${SURELOG_CMD}
endif

.DELETE_ON_ERROR:

# Build design
all: ${BOARD_BUILDDIR}/${TOP}.bit

${BOARD_BUILDDIR}:
	mkdir -p ${BOARD_BUILDDIR}

${BOARD_BUILDDIR}/${TOP}.eblif: ${SOURCES} ${XDC} ${SDC} ${PCF} | ${BOARD_BUILDDIR}
	cd ${BOARD_BUILDDIR} && symbiflow_synth -t ${TOP} ${SURELOG_OPT} -v ${SOURCES} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} ${XDC_CMD}

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

download: ${BOARD_BUILDDIR}/${TOP}.bit
	if [ $(TARGET)='unsupported' ]; then \
	  echo "The commands needed to download the bitstreams to the board type specified are not currently supported by the F4PGA makefiles. \
    Please see documentation for more information."; \
	fi
	openFPGALoader -b ${OFL_BOARD} ${BOARD_BUILDDIR}/${TOP}.bit

clean:
	rm -rf ${BUILDDIR}
