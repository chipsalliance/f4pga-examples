Understanding the Makefile in Symbiflow
==========================================
A key steep in creating your own designs is understanding how to use the Makefiles in symbiflow. This tutorial walks you through some of the key aspects of working with the Makefiles in symbiflow to allow for better debuging. 

Example 
========
To understand how the Makfiles within symbiflow are setup lets take a look at a more simple Makefile that will run the symbiflow counter test on the basys3 board. Highlighted lines within the code bellow are of particular intrest.

.. code-block:: bash
   :name: makefile-example
   :emphasize-lines: 4, 5, 11, 12, 22
   :linenos:

   mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
   current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))
   TOP:=top
   VERILOG:=${current_dir}/counter.v 
   DEVICE  := xc7a50t_test
   BITSTREAM_DEVICE := artix7
   BUILDDIR:=build

   PARTNAME:= xc7a35tcpg236-1
   XDC:=${current_dir}/basys3.xdc 
   BOARD_BUILDDIR := ${BUILDDIR}/basys3


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

Lets go over the highlighted lines one by one and discuss their purpose. 

Adding HDL files to your design
----------------------------------

