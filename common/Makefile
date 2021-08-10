BUILDDIR := ${current_dir}/build
BOARD_BUILDDIR := ${BUILDDIR}/${TARGET}

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