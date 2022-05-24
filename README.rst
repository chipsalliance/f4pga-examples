F4PGA examples
==============

.. image:: https://github.com/chipsalliance/f4pga-examples/workflows/doc-test/badge.svg?branch=master
   :target: https://github.com/chipsalliance/f4pga-examples/actions

.. image:: https://readthedocs.org/projects/f4pga-examples/badge/?version=latest
   :target: https://f4pga-examples.readthedocs.io/en/latest/?badge=latest
   :alt: Documentation Status

This repository provides example FPGA designs that can be built using the F4PGA open source toolchain.
These examples target the Xilinx 7-Series and the QuickLogic EOS S3 devices.

Please refer to the `project documentation <https://f4pga-examples.readthedocs.io>`_ for a proper guide on how to run
these examples as well as instructions on how to build and compile your own HDL designs using the F4PGA toolchain.

The repository includes:

* `xc7/ <./xc7>`_ and `eos-s3/ <./eos-s3>`_ - Examples for Xilinx 7-Series and EOS-S3 devices, including:

  * Verilog code

  * Pin constraints files

  * Timing constraints files

  * Makefiles for running the F4PGA toolchain

* `docs/ <./docs>`_ - Guide on how to get started with F4PGA and build provided examples

* `.github/ <./.github>`_ - Directory with CI configuration and scripts

The examples provided in this repository are automatically built and tested in CI by extracting necessary code snippets
with `tuttest <https://github.com/antmicro/tuttest>`_.
