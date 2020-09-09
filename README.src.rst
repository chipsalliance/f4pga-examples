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

* For the Artix-7 devices:

.. include:: xc7/README.rst
   :start-after:.. build_examples_include_begin_label
   :end-before:.. build_examples_include_end_label

Example design for the EOS S3 devices:
**************************************

* For the EOS S3 devices:

.. include:: eos-s3/README.rst
   :start-after:.. build_examples_include_begin_label
   :end-before:.. build_examples_include_end_label

