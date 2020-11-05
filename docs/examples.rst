Example designs
===============

Before building any example, set the installation directory to match what you
set it to earlier and prepare the enviroment:

.. tabs::

   .. group-tab:: Artix-7

      .. code-block:: bash
         :name: xc7-prepare-env

         export INSTALL_DIR=~/opt/symbiflow

         # adding symbiflow toolchain binaries to PATH
         export PATH="$INSTALL_DIR/xc7/install/bin:$PATH"
         source "$INSTALL_DIR/xc7/conda/etc/profile.d/conda.sh"
         conda activate xc7
        
   .. group-tab:: EOS S3

      .. code-block:: bash
         :name: eos-s3-prepare-env

         export INSTALL_DIR=~/opt/symbiflow

         # adding symbiflow toolchain binaries to PATH
         export PATH="$INSTALL_DIR/eos-s3/install/bin:$PATH"
         source "$INSTALL_DIR/eos-s3/conda/etc/profile.d/conda.sh"
         conda activate eos-s3
        

Xilinx 7-Series
---------------

Counter test
~~~~~~~~~~~~

To build the counter example, run any or all of the following commands:

.. code-block:: bash
   :name: xc7-counter

   pushd xc7/counter_test && make clean && TARGET="arty_35" make && popd
   pushd xc7/counter_test && make clean && TARGET="arty_100" make && popd
   pushd xc7/counter_test && make clean && TARGET="basys3" make && popd

Linux LiteX demo
~~~~~~~~~~~~~~~~

To build the litex example, run the following commands:

.. code-block:: bash
   :name: xc7-litex

   wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
   chmod +x litex_setup.py
   ./litex_setup.py init
   ./litex_setup.py install
   wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
   tar -xf riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
   export PATH=$PATH:$PWD/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14/bin/
   pushd litex/litex/boards/targets && ./arty.py --toolchain symbiflow --cpu-type vexriscv --build && popd

To build the linux-litex-demo example, run the following commands:

.. code-block:: bash
   :name: xc7-linux

   pushd xc7/linux_litex_demo && make && popd
   pushd xc7/linux_litex_demo && TARGET="arty_100" make && popd

PicoSoC demo
~~~~~~~~~~~~

To build the picosoc example, run the following commands:

.. code-block:: bash
   :name: xc7-picosoc

   pushd xc7/picosoc_demo && make && popd

QuickLogic EOS S3
-----------------

Button counter
~~~~~~~~~~~~~~

To build the example, run the following command:

.. code-block:: bash
   :name: eos-s3-counter

   pushd eos-s3/btn_counter && make && popd

.. code-block:: bash

   export INSTALL_DIR=~/opt/symbiflow
