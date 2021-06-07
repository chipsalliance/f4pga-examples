Using Symbiflow to upload your own designs
===========================================

This section describes how you can upload you're own designs to an FPGA from start to finish using only open source tools.

Prepareing your environment
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


File pre-requisits
-------------------



Creating the Makefile
----------------------


Building your personal projects
-------------------------------
Before you begin building your design navigate to the directory where you have stored your Makefile, virilog, and .xdc files:

.. code-block:: bash
   :name: your-directory

   cd <path to your directory>

Then, to build your design, simply run make on your current dirrectory: 

.. code-block:: bash
   :name: run-make

   make -C .


If your design builds withought error, the bitstream can be found in the following location:

.. code-block:: bash

   cd build/<board>

Finaly, for **Arty and Basys3**, you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"


.. tip::
    Many of the commands needed to build a project are run many times withought deviation. You might consider adding a few aliases or even a few bash functions to your .bashrc file to save yourself some typing or repeated coppy/paste. 
    For example, instead of using the cumbersome command used to upload the bitsream to arty or basys3 every time, you could just add the following lines to your bashrc file:
    
    .. code-block:: bash
       :name: bash-functions

        symbi_bit() { 
        #Creates and downloads the bitstream to Basys 3 or Arty boards:
        openocd -f /home/chem3000/opt/symbiflow/xc7/conda/envs/xc7/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"
       }

    Now whenever you need to download a bitstream to the arty or basysis you can simply type ``symbi_bit`` into the terminal and hit enter.

