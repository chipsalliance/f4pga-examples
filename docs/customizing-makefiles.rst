Customizing the Makefiles
==========================

A powerful tool in creating your own designs is understanding how to generate your own Makefile to
compile projects. This tutorial walks you through how to do that.

If you would like to use methods other than a Makefile to build and compile your designs 
(such as python or bash scripts) or if you would like to learn more about the various Symbiflow
commands used by the common Makefile to build and compile designs take a look at the
`Understanding Toolchain Commands <understanding-commands.html>`_ page.

Example 
-------

By including Symbiflow's provided Makefile.common in your designs, running the commands necessary for building 
your personal projects is incredibly simple. All you have to do is run a few simple commands and set
a few variables. 

To download Symbiflows common.Makefile run the following command inside the directory containing your 
build files:

.. code-block:: bash

   wget https://raw.githubusercontent.com/SymbiFlow/symbiflow-examples/master/common/Makefile.common

Then create a main makefile by running ``touch Makefile``. Add the following to the contents of the file.
Don't change the two highlighted lines unless you know what you are doing:

.. code-block:: bash
   :name: makefile-example
   :emphasize-lines: 1, 9
   :linenos:

   current_dir := ${CURDIR}
   # TOP := <put the name of your top module here>
   # SOURCES := ${current_dir}/<put your HDL sources here>

   # PCF := ${current_dir}/<name of your xdc file if applicable>
   # SDC := ${current_dir}/<name of your sdc file if applicable>
   # XDC := ${current_dir}/<name of your pcf file if applicable>

   include ${current_dir}/Makefile.common 

Lets talk briefly about each of the commands in the above makefile


Adding HDL Sources and Specifying the Top Module
------------------------------------------------

:ref:`Line 2<makefile-example>` in the Makefile shows how to define the name for your top level module. 
For example, if your top module was named ``module switches ( ...``  then you would simply uncomment 
line 3 and change the text in ``<>`` to ``TOP := switches``.

:ref:`Line 3<makefile-example>` in the Makefile shows how to add HDL files to the design. The general 
syntax is: ``SOURCES:=${current_dir}/<your HDL file path>``. You can also add multiple HDL files to a 
design using the following syntax:
 
 .. code-block:: bash
   :name: multi-file-example

   SOURCES := ${current_dir}/<HDL file 1> \
          ${current_dir}/<HDL file 2> \
          ${current_dir}/<HDL file 3> \
          ...
          ${current_dir}/<HDL file n> \


You could also use wildcards to collect all HDL file types of a specific extension and add them 
to your design. For example, if you wanted to add all verilog files within the current directory 
to your design, you could replace line 3 in the Makefile with:
 
 .. code-block:: bash
   :name: wildcard-example

    SOURCES := ${current_dir}/*.v

To include SystemVerilog HDL in your designs simply change the ``.v`` extension in the examples 
above to a ``.sv``.

.. note::

   As of this writing, symbiflow only offers full support for Verilog by default.
   SystemVerilog can also be run through the toolchain but more complicated 
   designs may not be fully supported. 


Constraint files
----------------

:ref:`Lines 5-7 <makefile-example>` show how you can specify what constraint files are being used for your design. The 
general syntax depends on whether you are using XDC files or a SDC+PCF pair:

.. tabs::

   .. group-tab:: XDC
   
      .. code-block:: bash

         XDC := ${current_dir}/<name of XDC file>

   .. group-tab:: SDC+PCF

         .. code-block:: bash

            PCF := ${current_dir}/<name of PCF file>
            SDC := ${current_dir}/<name of SDC file>


.. note:: 

   :ref:`Line 1 <makefile-example>` calls a make function ``CURDIR`` which returns the absolute
   path for the current directory. :ref:`Line 9 <makefile-example>` simply includes the path to the 
   common makefile. 


A Note on the example designs use of ifeq/else ifeq blocks
-------------------------------------------------------------

If you look at the Makefiles from the example designs within Symbiflow 
(i.e. counter test, Picosoc, etc.), you will find an ifeq else ifeq block. The following snippet 
is from lines 9-39 of `the Makefile from counter test <https://github.com/SymbiFlow/symbiflow-examples/blob/master/xc7/counter_test/Makefile>`_:


.. code-block:: bash
   :name: counter-test Makefile snippet
   :lineno-start: 5

   ifeq ($(TARGET),arty_35)
      XDC := ${current_dir}/arty.xdc
   else ifeq ($(TARGET),arty_100)
      XDC := ${current_dir}/arty.xdc
   else ifeq ($(TARGET),nexys4ddr)
      XDC := ${current_dir}/nexys4ddr.xdc
   else ifeq ($(TARGET),zybo)
      XDC := ${current_dir}/zybo.xdc
      SOURCES:=${current_dir}/counter_zynq.v
   else ifeq ($(TARGET),nexys_video)
      XDC := ${current_dir}/nexys_video.xdc
   else
      XDC := ${current_dir}/basys3.xdc
   endif

This snippet of code is an if else block used to set device specific constraints (i.e. ``basys3.xdc``, 
``nexys_video.xdc``). The code block determines what type of hardware is being used based upon a 
TARGET variable which is assumed to be defined before running make. For example, you may recall 
running ``TARGET="<board type>" make -C counter_test`` before building the counter test example. 
This command sets the TARGET variable to the type of hardware you are using. 

The if else block is completely optional. If you are only using one type of hardware for your 
designs you could just specify the TARGET variable within your makefile like so:

.. code-block:: bash
   :emphasize-lines: 2
   :linenos:

   current_dir := ${CURDIR}
   TARGET := basys3
   TOP := ${current_dir}/# put the name of your top module here
   SOURCES := ${current_dir}/# put your HDL sources here
   ...

By setting the ``TARGET`` variable within the Makefile itself, you don't even have to specify 
the TARGET variable before calling make. You can just use ``make -C <path to directory containing 
your design>``
