SymbiFlow examples
==================

This repository provides example FPGA designs that can be built using the SymbiFlow open source toolchain.
The examples target the Xilinx Artix-7 and the QuickLogic EOS S3 devices.

The repository includes:

* `eos-s3 </eos-s3>`_ - Example FPGA designs for the QuickLogic EOS S3 series of parts:

  * Verilog code
  * Pin constraints files
  * Timing constraints files
  * Makefiles for running the SymbiFlow toolchain

* `xc7 </xc7>`_ - Example FPGA designs for the Xilinx 7 series of parts:

  * Verilog code
  * Pin constraints files
  * Timing constraints files
  * Makefiles for running the SymbiFlow toolchain

* `.travis.yml <.travis.yml>`_ - Travis CI configuration file

Toolchain installation
----------------------

This section describes how to install the toolchain. This procedure is divided in two steps:

- Installing the Conda package manager
- Downloading the architecture definitions and installing the toolchain

#. Conda

.. code:: bash

        wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda_installer.sh

#. Toolchain

* For the Artix-7 devices:

.. code:: bash

        INSTALL_DIR="/opt/symbiflow/xc7"
        bash conda_installer.sh -b -p $INSTALL_DIR/conda && rm conda_installer.sh
        source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
        conda env create -f xc7/environment.yml
        conda activate xc7
        wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/66/20200914-111752/symbiflow-arch-defs-install-05d68df0.tar.xz | tar -xJ --one-top-level=$INSTALL_DIR/install
        conda deactivate

* For the EOS S3 devices:

.. code:: bash

        export INSTALL_DIR="/opt/symbiflow/eos-s3"
        bash conda_installer.sh -b -p $INSTALL_DIR/conda && rm conda_installer.sh
        source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
        conda env create -f eos-s3/environment.yml
        conda activate eos-s3
        wget -qO- https://quicklogic-my.sharepoint.com/:u:/p/kkumar/Eb7341Bq-XRAukVQ6oQ6PrgB-qdFbrsrPEON1yTa4krFSA?download=1 | tar -xJ -C $INSTALL_DIR
        cp -r $INSTALL_DIR/conda/envs/eos-s3/share/yosys/* $INSTALL_DIR/conda/envs/eos-s3/share/
        conda deactivate

Build Example Designs
---------------------

With the toolchain installed, you can build the example designs.
The example designs are provided in separate directories:

* ``xc7`` directory for the Artix-7 devices
* ``eos-s3`` directory for the EOS S3 devices

Example designs for the Artix-7 devices:
****************************************

* For the Artix-7 devices:

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

Example design for the EOS S3 devices:
**************************************

* For the EOS S3 devices:

Before building example, prepare environment:

.. code:: bash

        export INSTALL_DIR="/opt/symbiflow/eos-s3"
        export PATH="$INSTALL_DIR/install/bin:$PATH"
        source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
        conda activate eos-s3

        git clone https://github.com/SymbiFlow/symbiflow-examples && cd symbiflow-examples

To build the example, run the following command:

.. code:: bash

        pushd eos-s3/btn_counter && make && popd

