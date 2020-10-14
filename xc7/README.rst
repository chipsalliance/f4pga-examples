SymbiFlow Toolchain Examples for Xilinx 7 Series
================================================

#. ``counter`` - simple 4-bit counter driving LEDs. The design targets the `Basys3 board <https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/>`__ and the `Arty boards <https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/>`__.

#. ``picosoc`` - `picorv32 <https://github.com/cliffordwolf/picorv32>`__ based SoC. The design targets the `Basys3 board <https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/>`__.

#. ``linux_litex`` - `LiteX <https://github.com/enjoy-digital/litex>`__ based system with Linux capable `VexRiscv core <https://github.com/SpinalHDL/VexRiscv>`__. The design includes `DDR <https://github.com/enjoy-digital/litedram>`__ and `Ethernet <https://github.com/enjoy-digital/liteeth>`__ controllers. The design targets the `Arty boards <https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/>`__.

The Linux images for the ``linux_litex`` example can be built following the `linux on litex vexriscv <https://github.com/litex-hub/linux-on-litex-vexriscv>`__ instructions.
The ``linux_litex`` example is already provided with working Linux images.


Clone this repository
---------------------
If you have not already done so, clone this repository and `cd` into it:

.. code:: bash

   sudo apt install git
   git clone https://github.com/SymbiFlow/symbiflow-examples.git && cd symbiflow-examples



Setting up the toolchain
------------------------

Choose the installation directory (see the `README <../README.rst>`_ one level up for details):


.. code:: bash

    export INSTALL_DIR=~/opt/symbiflow   # or somewhere else you choose

.. toolchain_include_begin_label

.. code:: bash
        :name: xc7-setup-toolchain

        bash conda_installer.sh -b -p $INSTALL_DIR/xc7/conda
        source "$INSTALL_DIR/xc7/conda/etc/profile.d/conda.sh"
        conda env create -f xc7/environment.yml
        conda activate xc7
        wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/66/20200914-111752/symbiflow-arch-defs-install-05d68df0.tar.xz | tar -xJ --one-top-level=$INSTALL_DIR/xc7/install
        conda deactivate

.. toolchain_include_end_label

Building the examples
---------------------

.. build_examples_include_begin_label

Before building any example, set the installation directory to match what you set it to earlier,

.. code:: bash

    export INSTALL_DIR=~/opt/symbiflow

and prepare the environment:

.. code:: bash
        :name: xc7-prepare-env

        # adding symbiflow toolchain binaries to PATH
        export PATH="$INSTALL_DIR/xc7/install/bin:$PATH"
        source "$INSTALL_DIR/xc7/conda/etc/profile.d/conda.sh"
        conda activate xc7

To build the counter example, run any or all of the following commands:

.. code:: bash
        :name: xc7-counter

        pushd xc7/counter_test && make clean && TARGET="arty_35" make && popd
        pushd xc7/counter_test && make clean && TARGET="arty_100" make && popd
        pushd xc7/counter_test && make clean && TARGET="basys3" make && popd

To build the picosoc example, run the following commands:

.. code:: bash
        :name: xc7-picosoc

        pushd xc7/picosoc_demo && make && popd

To build the litex example, run the following commands:

.. code:: bash
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

.. code:: bash
        :name: xc7-linux

        pushd xc7/linux_litex_demo && make && popd
        pushd xc7/linux_litex_demo && TARGET="arty_100" make && popd

.. build_examples_include_end_label
