SymbiFlow Toolchain Examples for Xilinx 7 Series
================================================

#. ``counter`` - simple 4-bit counter driving LEDs. The design targets the `Basys3 board <https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/>`__ and the `Arty board <https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/>`__.

#. ``picosoc`` - `picorv32 <https://github.com/cliffordwolf/picorv32>`__ based SoC. The design targets the `Basys3 board <https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/>`__.

#. ``linux_litex`` - `LiteX <https://github.com/enjoy-digital/litex>`__ based system with Linux capable `VexRiscv core <https://github.com/SpinalHDL/VexRiscv>`__. The design includes `DDR <https://github.com/enjoy-digital/litedram>`__ and `Ethernet <https://github.com/enjoy-digital/liteeth>`__ controllers. The design targets the `Arty board <https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/>`__.

The Linux images for the ``linux_litex`` example can be built following the `linux on litex vexriscv <https://github.com/litex-hub/linux-on-litex-vexriscv>`__ instructions.
The ``linux_litex`` example is already provided with working Linux images.

Setting up the toolchain
------------------------

.. toolchain_include_begin_label

.. code:: bash

        INSTALL_DIR="/opt/symbiflow/xc7"
        bash conda_installer.sh -b -p $INSTALL_DIR/conda && rm conda_installer.sh
        source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
        conda env create -f xc7/environment.yml
        conda activate xc7
        wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/66/20200914-111752/symbiflow-arch-defs-install-05d68df0.tar.xz | tar -xJ --one-top-level=$INSTALL_DIR/install
        conda deactivate

.. toolchain_include_end_label

Building the examples
---------------------

.. build_examples_include_begin_label

Before building any example, prepare environment:

.. code:: bash

        export INSTALL_DIR="/opt/symbiflow/xc7"
        # adding symbiflow toolchain binaries to PATH
        export PATH="$INSTALL_DIR/install/bin:$PATH"
        source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
        conda activate xc7
        git clone https://github.com/SymbiFlow/symbiflow-examples && cd symbiflow-examples

To build the counter example, run the following commands:

.. code:: bash

        pushd xc7/counter_test && make clean && TARGET="arty_50" make && popd
        pushd xc7/counter_test && make clean && TARGET="arty_100" make && popd
        pushd xc7/counter_test && make clean && TARGET="basys3" make && popd

To build the picosoc example, run the following commands:

.. code:: bash

        pushd xc7/picosoc_demo && make && popd

To build the litex example, run the following commands:

.. code:: bash

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

        pushd xc7/linux_litex_demo && make && popd
        pushd xc7/linux_litex_demo && TARGET=arty_100 make && popd

.. build_examples_include_end_label
