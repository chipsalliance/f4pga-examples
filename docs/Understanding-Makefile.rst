Understanding the Makefile in Symbiflow
==========================================
A key steep in creating your own designs is understanding how to use the Makefiles in symbiflow. This tutorial walks you through some of the key aspects of working with the Makefiles in symbiflow to allow for better debugging. 

Example 
-------
To understand how the Makfiles within symbiflow are setup, lets take a look at a more simple Makefile that will run the symbiflow counter test on the basys3 board. Highlighted lines within the code below are of particular interest and will change depending on your design and hardware.

.. code-block:: bash
   :name: makefile-example
   :emphasize-lines: 4, 5, 9, 10
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
Line 4 in the Makefile shows how to add HDL files to the design. The general syntax is: ``<HDL language>:=${current_dir}/<your HDL file path>``. You can also add multiple HDL files to a design using the following syntax:
 
 .. code-block:: bash
   :name: multi-file-example

   <HDL language> := ${current_dir}/<HDL file 1> \

                     ${current_dir}/<HDL file 2>\

                     ${current_dir}/<HDL file 3> \

                     ${current_dir}/<HDL file 4> \
                     ...

You could also use wildcards to collect all HDL file types of a specific extension and add them to your design. For example, if you wanted to add all verilog files within the current directory to your design you could replace line 4 in the Makefile with:
 
 .. code-block:: bash
   :name: wildcard-example

    VERILOG := ${current_dir}/*.v


To include SystemVerilog in your design simply change the ``*.v`` above to a ``*.sv``. You might also want to change the ``VERILOG`` bash variables throughout the Makefile to ``SYSTEM_VERILOG`` to improve readability. 

.. note::

   As of this writing symbiflow only supports Verilog and SystemVerilog HDL by default.

Setting the device properties
------------------------------
Line 5 in the example sets the device type for the project. Several different board types are supported and a listing of the commands for each board type follows:

.. tabs::

   .. group-tab:: Arty_35T

      .. code-block:: bash
         :name: example-counter-a35t-group

         DEVICE:= xc7a50t_test

   .. group-tab:: Arty_100T

      .. code-block:: bash
         :name: example-counter-a100t-group

         DEVICE:= xc7a100t_test

   .. group-tab:: Nexus 4 DDR

      .. code-block:: bash
         :name: example-counter-nexys4ddr-group

         DEVICE:= xc7a100t_test

   .. group-tab:: Basys3

      .. code-block:: bash
         :name: example-counter-basys3-group

         DEVICE:= xc7a50t_test

   .. group-tab:: Zybo Z7

      .. code-block:: bash
         :name: example-counter-zybo-group

         DEVICE:= xc7z010_test

   .. group-tab:: Nexys Video

      .. code-block:: bash
         :name: example-counter-nexys_video-group

         DEVICE:= xc7a200t_test


As shown on line 9 of the example makefile you will also need to define the part your FPGA uses. To do this you need to add the following line of code to your makefile depending on your hardware:

.. tabs::

   .. group-tab:: Arty_35T

      .. code-block:: bash
         :name: example-part-a35t-group

         PARTNAME := xc7a35tcsg324-1

   .. group-tab:: Arty_100T

      .. code-block:: bash
         :name: example-part-a100t-group

         PARTNAME:= xc7a100tcsg324-1

   .. group-tab:: Nexus 4 DDR

      .. code-block:: bash
         :name: example-part-nexys4ddr-group

         PARTNAME:= xc7a100tcsg324-1

   .. group-tab:: Basys3

      .. code-block:: bash
         :name: example-part-basys3-group

         PARTNAME:= xc7a35tcpg236-1

   .. group-tab:: Zybo Z7

      .. code-block:: bash
         :name: example-part-zybo-group

         PARTNAME:= xc7z010clg400-1

   .. group-tab:: Nexys Video

      .. code-block:: bash
         :name: example-part-nexys_video-group

         PARTNAME:= xc7a200tsbg484-1


Constraint files
----------------

Line 10 shows how you can specify what the constraint files are being used for your design. The general syntax depends on wether you are using XDC files or a SDC+PCF pair:

.. tabs::

   .. group-tab:: XDC
   
      .. code-block:: bash

         XDC:=${current_dir}/<name of XDC file>

   .. group-tab:: SDC+PCF

         .. code-block:: bash

            PCF := ${current_dir}/<name of PCF file>
            SDC := ${current_dir}/<name of SDC file>

Note that the lines 22, 25, 28, and 31 (.eblif, net, place, and route) will also need to change depending on if you use an XDC file or some combination of SDC, PCF and XDC files. The following snippets show the differences and the areas that will need to change:

.. tabs::

   .. group-tab:: XDC

      .. code-block:: bash
         :emphasize-lines: 2

         ${BOARD_BUILDDIR}/${TOP}.eblif: | ${BOARD_BUILDDIR}
            cd ${BOARD_BUILDDIR} && symbiflow_synth -t ${TOP} -v ${VERILOG} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} -x ${XDC} 2>&1 > /dev/null

         ${BOARD_BUILDDIR}/${TOP}.net: ${BOARD_BUILDDIR}/${TOP}.eblif
            cd ${BOARD_BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} 2>&1 > /dev/null

         ${BOARD_BUILDDIR}/${TOP}.place: ${BOARD_BUILDDIR}/${TOP}.net
            cd ${BOARD_BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} -n ${TOP}.net -P ${PARTNAME} 2>&1 > /dev/null

         ${BOARD_BUILDDIR}/${TOP}.route: ${BOARD_BUILDDIR}/${TOP}.place
            cd ${BOARD_BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} 2>&1 > /dev/null

   .. group-tab:: SDC+PCF

      .. code-block:: bash
         :emphasize-lines: 5, 8, 11

         ${BOARD_BUILDDIR}/${TOP}.eblif: | ${BOARD_BUILDDIR}
            cd ${BOARD_BUILDDIR} && symbiflow_synth -t ${TOP} -v ${VERILOG} -d ${BITSTREAM_DEVICE} -p ${PARTNAME}
 
         ${BOARD_BUILDDIR}/${TOP}.net: ${BOARD_BUILDDIR}/${TOP}.eblif
            cd ${BOARD_BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} -s ${SDC}
      
         ${BOARD_BUILDDIR}/${TOP}.place: ${BOARD_BUILDDIR}/${TOP}.net
            cd ${BOARD_BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} -p ${PCF} -n ${TOP}.net -P ${PARTNAME} -s ${SDC} 2>&1 > /dev/null
         
         ${BOARD_BUILDDIR}/${TOP}.route: ${BOARD_BUILDDIR}/${TOP}.place
            cd ${BOARD_BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 > /dev/null
         

   .. group-tab:: SDC+PCF+XDC

      .. code-block:: bash
         :emphasize-lines: 2, 5, 8, 11 

         ${BOARD_BUILDDIR}/${TOP}.eblif: | ${BOARD_BUILDDIR}
            cd ${BOARD_BUILDDIR} && symbiflow_synth -t ${TOP} -v ${VERILOG} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} -x ${XDC} 2>&1 > /dev/null

         ${BOARD_BUILDDIR}/${TOP}.net: ${BOARD_BUILDDIR}/${TOP}.eblif
            cd ${BOARD_BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 > /dev/null

         ${BOARD_BUILDDIR}/${TOP}.place: ${BOARD_BUILDDIR}/${TOP}.net
            cd ${BOARD_BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} -p ${PCF} -n ${TOP}.net -P ${PARTNAME} -s ${SDC} 2>&1 > /dev/null

         ${BOARD_BUILDDIR}/${TOP}.route: ${BOARD_BUILDDIR}/${TOP}.place
            cd ${BOARD_BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} -s ${SDC} 2>&1 > /dev/null

Lines 33-37 (running ``symbiflow_write_fasm`` and ``symbiflow_write_bitstream``) typically do not change from design to design.