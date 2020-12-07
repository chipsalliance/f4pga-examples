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

Clone this repository
---------------------

If you have not already done so, clone this repository and ``cd`` into it:

.. code:: bash

    sudo apt install git
    git clone https://github.com/SymbiFlow/symbiflow-examples.git && cd symbiflow-examples


Prerequisites
-------------

Install the following prerequisites before using symbiflow-examples:

* For Ubuntu:

.. code:: bash
   :name: install-req-ubuntu

   apt update && apt install -y wget

* For CentOS:

.. code:: bash
   :name: install-req-centos

   yum install -y wget which

Toolchain installation
----------------------

This section describes how to install the toolchain. This procedure is divided in three steps:

- Installing the Conda package manager
- Choosing an installation directory
- Downloading the architecture definitions and installing the toolchain

1. Conda

.. code:: bash
   :name: wget-conda

   wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda_installer.sh

2. Choose the install directory

The install directory can either be in your home directory
such as ``~/opt/symbiflow`` or in a system directory such as ``/opt/symbiflow``.
If you choose a system directory, you will need root permission to perform the installation,
and so you will need to add some ``sudo`` commands to the instructions below.

.. code:: bash

   INSTALL_DIR=~/opt/symbiflow

3. Toolchain

* For the Artix-7 devices:

.. code:: bash
        :name: xc7-setup-toolchain

        bash conda_installer.sh -b -p $INSTALL_DIR/xc7/conda
        source "$INSTALL_DIR/xc7/conda/etc/profile.d/conda.sh"
        conda env create -f xc7/environment.yml
        conda activate xc7
        mkdir -p $INSTALL_DIR/xc7/install
        wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/112/20201208-080919/symbiflow-arch-defs-install-7c1267b7.tar.xz | tar -xJC $INSTALL_DIR/xc7/install
        wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/112/20201208-080919/symbiflow-arch-defs-xc7a50t_test-7c1267b7.tar.xz | tar -xJC $INSTALL_DIR/xc7/install
        wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/112/20201208-080919/symbiflow-arch-defs-xc7a100t_test-7c1267b7.tar.xz | tar -xJC $INSTALL_DIR/xc7/install
        wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/112/20201208-080919/symbiflow-arch-defs-xc7z010_test-7c1267b7.tar.xz | tar -xJC $INSTALL_DIR/xc7/install
        conda deactivate

* For the EOS S3 devices:

.. code:: bash
        :name: eos-s3-setup-toolchain

        bash conda_installer.sh -b -p $INSTALL_DIR/eos-s3/conda
        source "$INSTALL_DIR/eos-s3/conda/etc/profile.d/conda.sh"
        conda env create -f eos-s3/environment.yml
        conda activate eos-s3
        wget -qO- https://quicklogic-my.sharepoint.com/:u:/p/kkumar/EWuqtXJmalROpI2L5XeewMIBRYVCY8H4yc10nlli-Xq79g?download=1 | tar -xJ -C $INSTALL_DIR/eos-s3/
        conda deactivate

Build Example Designs
---------------------

With the toolchain installed, you can build the example designs.
The example designs are provided in separate directories:

* ``xc7`` directory for the Artix-7 devices
* ``eos-s3`` directory for the EOS S3 devices



Example designs for the Artix-7 devices:
****************************************

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

        pushd xc7/counter_test && TARGET="arty_35" make && popd
        pushd xc7/counter_test && TARGET="arty_100" make && popd
        pushd xc7/counter_test && TARGET="basys3" make && popd

To build the picosoc example, run the following commands:

.. code:: bash
        :name: xc7-picosoc

        pushd xc7/picosoc_demo && make && popd

To build the litex example, run the following commands:

.. code:: bash
        :name: xc7-litex

        mkdir xc7/litex_demo
        pushd xc7/litex_demo
        wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
        chmod +x litex_setup.py
        ./litex_setup.py init
        ./litex_setup.py install
        wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
        tar -xf riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
        export PATH=$PATH:$PWD/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14/bin/
        pushd litex/litex/boards/targets && ./arty.py --toolchain symbiflow --cpu-type vexriscv --sys-clk-freq 80e6 --no-ident-version --build && popd
        popd

To build the linux-litex-demo example, run the following commands:

.. code:: bash
        :name: xc7-linux

        pushd xc7/linux_litex_demo && make && popd
        pushd xc7/linux_litex_demo && TARGET="arty_100" make && popd

Example design for the EOS S3 devices:
**************************************

Before building any example, set the installation directory to match what you set it to earlier,

.. code:: bash

    export INSTALL_DIR=~/opt/symbiflow

and prepare the environment:

.. code:: bash
        :name: eos-s3-prepare-env

        export PATH="$INSTALL_DIR/eos-s3/install/bin:$PATH"
        source "$INSTALL_DIR/eos-s3/conda/etc/profile.d/conda.sh"
        conda activate eos-s3

To build the example, run the following command:

.. code:: bash
        :name: eos-s3-counter

        pushd eos-s3/btn_counter && make && popd

