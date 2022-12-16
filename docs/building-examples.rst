.. _Building-Examples:

Building example designs
########################

Before building any example, set the installation directory to match what you
set it to earlier, for example:

.. code-block:: bash
   :name: export-install-dir

   export F4PGA_INSTALL_DIR=~/opt/f4pga

Select your FPGA family:

.. tabs::

   .. group-tab:: Artix-7

      .. code-block:: bash
         :name: fpga-fam-xc7

         export FPGA_FAM="xc7"

   .. group-tab:: EOS S3

      .. code-block:: bash
         :name: fpga-fam-eos-s3

         export FPGA_FAM="eos-s3"

Next, prepare the environment:

.. code-block:: bash
   :name: conda-prep-env

   source "$F4PGA_INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh"

Finally, enter your working Conda environment:

.. code-block:: bash
   :name: conda-act-env

   conda activate $FPGA_FAM

.. tip::

   You will need to run the commands for setting the path and source of your conda environment
   each time you open a new terminal. You will also need to activate the Conda environment for
   your hardware before you attempt to build your designs. It might be a good idea to add the
   above commands to your ``.bashrc`` either as default commands that run each time you open a
   new terminal or aliases to save yourself some repetitive typing.

.. note::

   If you don't know how to upload any of the following examples onto your
   development board, please refer to the Running examples section.

.. note::

   Make sure you have executed all the above commands, or otherwise you may encounter errors when
   building the designs.


Xilinx 7-Series
===============

Enter the directory that contains examples for Xilinx 7-Series FPGAs:

.. code-block:: bash
   :name: enter-dir-xc7

   cd xc7

Then, follow the guidelines for each example:

.. toctree::

   xc7/counter_test
   xc7/timer
   xc7/pulse_width_led
   xc7/picosoc_demo
   xc7/litex_demo
   xc7/linux_litex_demo
   xc7/litex_sata_demo

QuickLogic EOS S3
=================

Enter the directory that contains examples for QuickLogic EOS S3:

.. code-block:: bash
   :name: enter-dir-eos-s3

   cd eos-s3

Then, follow the guidelines for each example:

.. toctree::

   eos-s3/btn_counter
