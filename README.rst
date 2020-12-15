SymbiFlow examples
==================

.. image:: https://github.com/symbiflow/symbiflow-examples/workflows/doc-test/badge.svg?branch=master
   :target: https://github.com/SymbiFlow/symbiflow-examples/actions

.. image:: https://readthedocs.org/projects/symbiflow-examples/badge/?version=latest
   :target: https://symbiflow-examples.readthedocs.io/en/latest/?badge=latest
   :alt: Documentation Status

This repository provides example FPGA designs that can be built using the
SymbiFlow open source toolchain. These examples target the Xilinx 7-Series and
the QuickLogic EOS S3 devices.

The repository includes:

* `xc7/ <./xc7>`_ and `eos-s3/ <./eos-s3>`_ - Examples for Xilinx 7-Series and EOS-S3 devices, including:

  * Verilog code
  * Pin constraints files
  * Timing constraints files
  * Makefiles for running the SymbiFlow toolchain
* `docs/ <./docs>`_ - Guide on how to get started with SymbiFlow and build provided examples
* `.github/ <./.github>`_ - Directory with CI configuration and scripts

Please refer to the `project documentation <https://symbiflow-examples.readthedocs.io>`_
for a proper guide on how to run these examples. The examples provided by this
repository are automatically built by extracting necessary code snippets with
`tuttest <https://github.com/antmicro/tuttest>`_.

Building those docs
-------------------

To build Sphinx documentation, you need at least Python 3.6. You will also need
to install Sphinx v3.3.0 and additional dependencies, which you can get with
``pip``::

   pip install -r docs/requirements.txt

Next, just run::

   make -C docs html

The output will be found in the ``docs/_build/html`` directory.

Running "CI" locally
--------------------

The CI uses a bunch of scripts in the `.github/scripts/ <./.github/scripts>`_
directory to execute the needed tests. You can use the same scripts locally
to test without having to wait for the online CIs to pass if you
want to quickly test stuff.

For this, you will need `tuttest <https://github.com/antmicro/tuttest/>`_,
which you can install with::

    pip install git+https://github.com/antmicro/tuttest

* ``<fpga-family>`` is one of ``{eos-s3, xc7}`` (the two currently
  covered platforms - EOS-S3 and Xilinx series 7).
* ``<os>`` is one of ``{ubuntu, debian, centos}`` (currently supported operating systems).

To install the toolchain (just the first time), run::

   .github/scripts/install-toolchain.sh <fpga-family> <os> | bash -c "$(cat /dev/stdin)"

To build all the examples locally, just run::

   .github/scripts/build-examples.sh <fpga-family>  | bash -c "$(cat /dev/stdin)"
