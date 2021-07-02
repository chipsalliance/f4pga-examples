Building Custom Designs
========================

This section describes how to compile and download your own designs to an FPGA using only 
the symbiflow tool chain.

Setup Prior to Running the Toolchain
--------------------------------------
Before building any examples, you will need to first install the toolchain. To do this, follow the 
steps in `Getting Symbiflow <getting-symbiflow.html>`_. After you have downloaded the toolchain, 
set the installation directory to match what you set it to earlier, for example:

.. code-block:: bash
   :name: export-install-dir

   export INSTALL_DIR=~/opt/symbiflow

Select your FPGA family:

.. tabs::

   .. group-tab:: Artix-7

      .. code-block:: bash
         :name: fpga-fam-xc7

         FPGA_FAM="xc7"

   .. group-tab:: EOS S3

      .. code-block:: bash
         :name: fpga-fam-eos-s3

         FPGA_FAM="eos-s3"

Next, set the path and source for your conda environment:

.. code-block:: bash
   :name: conda-prep-env

   export PATH="$INSTALL_DIR/$FPGA_FAM/install/bin:$PATH";
   source "$INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh"

Finally, activate your Conda environment:

.. code-block:: bash
   :name: conda-act-env

   conda activate $FPGA_FAM


.. note::

   You will need to run the commands for setting the path and source of your conda environment 
   each time you open a new terminal. You will also need to activate the Conda environment for 
   your hardware before you attempt to build your designs. It might be a good idea to add the 
   above commands to your ``.bashrc`` either as default commands that run each time you open a 
   new terminal or aliases to save yourself some repetitive typing. 


Preparing Your Design 
----------------------
Building a design in symbiflow requires three parts, the HDL files for your design, a constraints
file, and a Makefile. For simplicity, all three of these design files should be moved to a single
directory. The location of the directory does not mater as long as the three design files are all 
within it.

HDL Files
++++++++++
Symbiflow provides full support for Verilog. Some support for SystemVerilog HDL code is also 
provided, although more complicated designs written in SystemVerilog may not build properly under 
Yosys. Use whichever method you prefer and add your design files to the directory of choice. 
If you are using the provided Makefiles to build your design, the top level module in your HDL 
code should be declared as ``module top (...``. Failure to do so will result in an error from 
symbiflow_synth stating something similar to ``ERROR: Module 'top' not found!`` If you are using 
your own makefiles or commands, you can specify your top level module name using the -t flag in 
symbiflow_synth. 



Constraint File
++++++++++++++++
The Symbiflow tool chain supports both .XDC and .PCF+.SDC formats for constraints. 
You can use XDC to define IOPAD, IOSETTINGS, and clock constraints. SDCs can be used to 
define clock constraints and PCFs can be used to define IOPAD constraints only. Use whichever 
method you prefer and add your constraint file(s) to your design directory.

Note that if you use an XDC file as your constraint and neglect to include your own SDC, the 
toolchain will automatically generate one to provide clock constraints to VTR.

Makefile
+++++++++
To learn about how Makefiles in symbiflow work, see 
`Understanding the Makefile in Symbiflow <Understanding-Makefile.html>`_ page.

If you have used verilog as your HDL and an XDC as your constraint, you can add this 
:download:`Makefile <master_makefile/Makefile>` to your design directory instead of building your
own. If you have used a different HDL than verilog or have used a combination of PCF+SDC 
constraint files, you can find instructions for how to modify the provided makefile or create 
your own in `Understanding the Makefile in Symbiflow <Understanding-Makefile.html>`_.  


Building your personal projects 
-------------------------------

Before you begin building your design, navigate to the directory where you have stored your 
Makefile, HDL, and constraint files:

.. code-block:: bash
   :name: your-directory

   cd <path to your directory>


Then, depending on your board type run: 

.. tabs::

   .. group-tab:: Arty_35T

      .. code-block:: bash
         :name: example-counter-a35t-group

         TARGET="arty_35" make -C .

   .. group-tab:: Arty_100T

      .. code-block:: bash
         :name: example-counter-a100t-group

         TARGET="arty_100" make -C .

   .. group-tab:: Nexus4

      .. code-block:: bash
         :name: example-counter-nexys4ddr-group

         TARGET="nexys4ddr" make -C .

   .. group-tab:: Basys3

      .. code-block:: bash
         :name: example-counter-basys3-group

         TARGET="basys3" make -C .



If your design builds without error, the bitstream can be found in the following location:

.. code-block:: bash

   cd build/<board>

Once you navigate to the directory containing the bitstream, use the following commands on the 
**Arty and Basys3** to upload the design to your board:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"


.. tip::
    Many of the commands needed to build a project are run multiple times with little to no 
    variation. You might consider adding a few aliases or even a few bash functions to your 
    .bashrc file to save yourself some typing or repeated copy/paste. For example, instead of 
    using the somewhat cumbersome command used to upload the bitstream to Xilinx 7 series FPGA 
    every time, you could just add the following lines to your .bashrc file:
    
    .. code-block:: bash
       :name: bash-functions

        symbi_bit() { 
        #Creates and downloads the bitstream to Xilinx 7 series FPGA:
        openocd -f <Your install directory>/xc7/conda/envs/xc7/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"
       }

    Now whenever you need to download a bitstream to the Xilinx-7 series you can simply type 
    ``symbi_bit`` into the terminal and hit enter.

