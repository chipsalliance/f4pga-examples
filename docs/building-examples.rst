Building example designs
========================

Before building any example, set the installation directory to match what you
set it to earlier, for example:

.. code-block:: bash
   :name: export-install-dir

   export INSTALL_DIR=~/opt/symbiflow

Select your fpga family:

.. tabs::

   .. group-tab:: Artix-7

      .. code-block:: bash
         :name: fpga-fam-xc7

         FPGA_FAM="xc7"

   .. group-tab:: EOS S3

      .. code-block:: bash
         :name: fpga-fam-eos-s3

         FPGA_FAM="eos-s3"

Next, prepare the enviroment:

.. code-block:: bash
   :name: conda-prep-env

   export PATH="$INSTALL_DIR/$FPGA_FAM/install/bin:$PATH";
   source "$INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh"

Finally, enter your working Conda enviroment:

.. code-block:: bash
   :name: conda-act-env

   conda activate $FPGA_FAM

.. note::

   If you don't know how to upload any of the following examples onto your
   development board, please refer to the Running examples section.


Xilinx 7-Series
---------------

Enter the directory that contains examples for Xilinx 7-Series FPGAs:

.. code-block:: bash
   :name: enter-dir-xc7

   cd xc7

.. jinja:: xc7_counter_test
   :file: templates/example.jinja

.. jinja:: xc7_picosoc_demo
   :file: templates/example.jinja

.. jinja:: xc7_linux_litex_demo
   :file: templates/example.jinja


QuickLogic EOS S3
-----------------

Enter the directory that contains examples for QuickLogic EOS S3:

.. code-block:: bash
   :name: enter-dir-eos-s3

   cd eos-s3

.. jinja:: eos-s3_btn_counter
   :file: templates/example.jinja
