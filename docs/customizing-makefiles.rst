Customizing the Makefiles from Symbiflow-examples For Your Own Designs
=======================================================================
A key step in creating your own designs is understanding how to generate your own Makefiles to 
properly compile and build designs with the symbiflow toolchain. This tutorial walks you through 
some of the key aspects of working with Makefiles and explains how you can create Makefiles for 
your own designs.

Example 
-------

Every design in symbiflow has its own makefile. For example 
`Counter-test <https://github.com/SymbiFlow/symbiflow-examples/blob/master/xc7/counter_test/Makefile>`_,  
`Linux Litex Demo <https://github.com/SymbiFlow/symbiflow-examples/blob/master/xc7/linux_litex_demo/Makefile>`_, 
and `Picosoc Demo <https://github.com/SymbiFlow/symbiflow-examples/blob/master/xc7/picosoc_demo/Makefile>`_ 
all have there own unique Makefiles for compiling and building respective designs. To understand 
how to set up a Makefile in symbiflow, lets take a look at a simple Makefile. The following code 
is based off of the Makefile within `Counter-test <https://github.com/SymbiFlow/symbiflow-examples/blob/master/xc7/counter_test/Makefile>`_ 
and has been modified slightly for simplicity. Highlighted lines within the code below are of 
particular interest and will change depending on your specific design elements and hardware. 
Lines that are not highlighted do not change from design to design and can be copy and pasted 
into your own Makefile.

.. code-block:: bash
   :name: makefile-example
   :emphasize-lines: 4, 5, 9, 10, 22, 25, 28, 31
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


Adding HDL files to your design
----------------------------------
Line 4 in the Makefile shows how to add HDL files to the design. The general syntax is: 
``<HDL language>:=${current_dir}/<your HDL file path>``. You can also add multiple HDL files to a 
design using the following syntax:
 
 .. code-block:: bash
   :name: multi-file-example

   <HDL language> := ${current_dir}/<HDL file 1> \

                     ${current_dir}/<HDL file 2> \

                     ${current_dir}/<HDL file 3> \

                     ${current_dir}/<HDL file 4> \
                     ...

You could also use wildcards to collect all HDL file types of a specific extension and add them 
to your design. For example, if you wanted to add all verilog files within the current directory 
to your design, you could replace line 4 in the Makefile with:
 
 .. code-block:: bash
   :name: wildcard-example

    VERILOG := ${current_dir}/*.v


To include SystemVerilog HDL in your designs simply change the ``.v`` extension in the examples 
above to a ``.sv``. You might also want to change the ``VERILOG`` bash variables throughout the 
Makefile to ``SYSTEM_VERILOG`` to improve readability. 

.. note::

   As of this writing symbiflow only offers full support for Verilog by default.
   SystemVerilog can also be run through the toolchain but more complicated commands are not fully
   supported. 

Setting the Board Type and Part Name
-------------------------------------
Line 5 in the example Makefile defines the board type for the project. The use of the term DEVICE 
may be confusing, but it does refer to a board type as you can see from the context below.  

Several different board types are supported and a listing of the commands for each board type follow:

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


As shown on line 9 of the example makefile you will also need to define the specific FPGA part 
your board uses. To do this you need to add the following line of code to your makefile depending 
on your hardware:

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

Line 10 shows how you can specify what the constraint files are being used for your design. The 
general syntax depends on whether you are using XDC files or a SDC+PCF pair:

.. tabs::

   .. group-tab:: XDC
   
      .. code-block:: bash

         XDC:=${current_dir}/<name of XDC file>

   .. group-tab:: SDC+PCF

         .. code-block:: bash

            PCF := ${current_dir}/<name of PCF file>
            SDC := ${current_dir}/<name of SDC file>

Note that the lines 22, 25, 28, and 31 (.eblif, net, place, and route) will also need to change 
depending on if you use an XDC file or some combination of SDC, PCF and XDC files. The following 
snippets show the differences and the areas that will need to change:

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

Lines 33-37 (running ``symbiflow_write_fasm`` and ``symbiflow_write_bitstream``) typically do 
not change within the makefile from design to design. 

If you would like to learn more about these commands or if you are using methods other than a 
makefile to build and compile your designs (such as python or bash scripts) take a look at 
`Understanding Toolchain Commands <understanding-commands.html>`_.

A Note on the example designs use of ifeq/else ifeq blocks
-------------------------------------------------------------

If you look at many of the Makefiles from the example designs within symbiflow 
(i.e. counter-test, Picosoc, etc.), you will find an ifeq else ifeq block. The following snippet 
is from lines 9-39 of `the Makefile from Counter-test <https://github.com/SymbiFlow/symbiflow-examples/blob/master/xc7/counter_test/Makefile>`_:


.. code-block:: bash
   :name: counter-test Makefile snippet

   ifeq ($(TARGET),arty_35)
   PARTNAME := xc7a35tcsg324-1
   XDC:=${current_dir}/arty.xdc
   BOARD_BUILDDIR := ${BUILDDIR}/arty_35
   else ifeq ($(TARGET),arty_100)
   PARTNAME:= xc7a100tcsg324-1
   XDC:=${current_dir}/arty.xdc
   DEVICE:= xc7a100t_test
   BOARD_BUILDDIR := ${BUILDDIR}/arty_100
   else ifeq ($(TARGET),nexys4ddr)
   PARTNAME:= xc7a100tcsg324-1
   XDC:=${current_dir}/nexys4ddr.xdc
   DEVICE:= xc7a100t_test
   BOARD_BUILDDIR := ${BUILDDIR}/nexys4ddr
   else ifeq ($(TARGET),zybo)
   PARTNAME:= xc7z010clg400-1
   XDC:=${current_dir}/zybo.xdc
   DEVICE:= xc7z010_test
   BITSTREAM_DEVICE:= zynq7
   BOARD_BUILDDIR := ${BUILDDIR}/zybo
   VERILOG:=${current_dir}/counter_zynq.v
   else ifeq ($(TARGET),nexys_video)
   PARTNAME:= xc7a200tsbg484-1
   XDC:=${current_dir}/nexys_video.xdc
   DEVICE:= xc7a200t_test
   BOARD_BUILDDIR := ${BUILDDIR}/nexys_video
   else
   PARTNAME:= xc7a35tcpg236-1
   XDC:=${current_dir}/basys3.xdc
   BOARD_BUILDDIR := ${BUILDDIR}/basys3
   endif

This snippet of code is an if else block used to set the specific PARTNAME and DEVICE parameters 
for different types of hardware. Since each FPGA has a unique pin configuration, the block also 
defines a constraint file specific to the hardware being used (i.e. ``basys3.xdc``, 
``nexys_video.xdc``). The code block determines what type of hardware is being used based upon a 
TARGET variable which is assumed to be defined before running make. For example, you may recall 
running ``TARGET="<board type>" make -C counter_test`` before building the counter-test example. 
This command sets the TARGET variable to the type of hardware you are using. 

The if else block is completely optional. If you are only using one type of hardware for your 
designs then you could just use something similar to lines 5, 9 and 10 in our example:

.. code-block:: bash
   :name: device-partname-snippet

   DEVICE  := xc7a50t_test

   PARTNAME:= xc7a35tcpg236-1
   XDC:=${current_dir}/<name of XDC file>

If you plan on using multiple types of hardware for your designs, then it might be better to just 
copy the if else blocks from one of the symbiflow-examples. Note that you may need to change the 
names for the XDC or PCF+SDC parameters to match the names you have used. Also remember that you 
will need to set the TARGET variable before running make on your design.
