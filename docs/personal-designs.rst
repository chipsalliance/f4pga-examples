Using Symbiflow to upload your own designs
===========================================

This section describes how to upload you're own designs to an FPGA from start to finish using only open source tools.

Preparing your environment
----------------------------
Before building any example, set the installation directory to match what you
set it to earlier, for example:

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

Next, prepare the environment:

.. code-block:: bash
   :name: conda-prep-env

   export PATH="$INSTALL_DIR/$FPGA_FAM/install/bin:$PATH";
   source "$INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh"

Finally, enter your working Conda environment:

.. code-block:: bash
   :name: conda-act-env

   conda activate $FPGA_FAM


.. note::

   You will need to run the commands for preparing your conda environment each time you open a new terminal. You will also need to activate the Conda environment for your hardware before you attempt to build your designs. It might be a good idea to add the above commands to your ``.bashrc`` either as functions or aliases to save yourself some repetitive typing. 


Preparing Your Design
----------------------
Building a design in symbiflow requires three simple parts, the HDL files for your design, a constraints file, and a Makefile. For simplicity, all three of these design parts should be moved to a single directory.

HDL files
++++++++++
Symbiflow provides support for both Verilog and SystemVerilog HDL code. Use whichever method you prefer and add your design files to the directory of choice. If you are using the provided Makefiles to build your design, your top level module should be declared as ``module top (...``. Failure to do so will result in an error during the build process stating something to the effect of ``ERROR: Module 'top' not found!``



Constraint file
++++++++++++++++
The Symbiflow tool chain supports both .XDC and .PCF+.SDC formats for constraint files. Use whichever method you prefer and add your constraint file(s) to the design directory.


Makefile
+++++++++
To learn about how Makefiles in symbiflow work, see the `Understanding the Makefile in Symbiflow <Understanding-Makefile.html>`_ page.

If you have used verilog as your HDL and an XDC as your constraint, you can add this :download:`Makefile <master_makefile/Makefile>` to your design directory instead of building your own.


Building your personal projects 
-------------------------------
Before you begin building your design, navigate to the directory where you have stored your Makefile, HDL, and constraint files:

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

Once you navigate to the directory containing the bitstream, use the following commands on the **Arty and Basys3** to upload the design to your board:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"


.. tip::
    Many of the commands needed to build a project are run multiple times with little to no variation. You might consider adding a few aliases or even a few bash functions to your .bashrc file to save yourself some typing or repeated copy/paste. 
    For example, instead of using the somewhat cumbersome command used to upload the bitstream to Xilinx 7 series FPGA every time, you could just add the following lines to your bashrc file:
    
    .. code-block:: bash
       :name: bash-functions

        symbi_bit() { 
        #Creates and downloads the bitstream to Xilinx 7 series FPGA:
        openocd -f <Your install directory>/xc7/conda/envs/xc7/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"
       }

    Now whenever you need to download a bitstream to the Xilinx-7 series you can simply type ``symbi_bit`` into the terminal and hit enter.

