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
The only required prerequisite is ``wget``. You can install it using:

* For Ubuntu:

.. code:: bash
   :name: install-wget-ubuntu

   apt update && apt install -y wget

* For CentOS:

.. code:: bash
   :name: install-wget-centos

   yum install -y wget

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

.. include:: xc7/README.rst
   :start-after:.. toolchain_include_begin_label
   :end-before:.. toolchain_include_end_label


* For the EOS S3 devices:

.. include:: eos-s3/README.rst
   :start-after:.. toolchain_include_begin_label
   :end-before:.. toolchain_include_end_label


Build Example Designs
---------------------

With the toolchain installed, you can build the example designs.
The example designs are provided in separate directories:

* ``xc7`` directory for the Artix-7 devices
* ``eos-s3`` directory for the EOS S3 devices



Example designs for the Artix-7 devices:
****************************************

.. include:: xc7/README.rst
   :start-after:.. build_examples_include_begin_label
   :end-before:.. build_examples_include_end_label


Example design for the EOS S3 devices:
**************************************

.. include:: eos-s3/README.rst
   :start-after:.. build_examples_include_begin_label
   :end-before:.. build_examples_include_end_label

