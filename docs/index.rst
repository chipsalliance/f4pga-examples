Welcome to F4PGA examples!
##########################

This guide explains how to get started with F4PGA and build example designs from the :gh:`F4PGA Examples <chipsalliance/f4pga-examples>`
GitHub repository.
It currently focuses on the following FPGA families:

- Artix-7 from Xilinx,
- EOS-S3 from QuickLogic.

Follow this guide to:

- :doc:`install F4PGA <getting>` and all of its dependencies,
- :doc:`build <building-examples>` and :doc:`upload <running-examples>`
  example designs onto the devboard of your choice.
- compile and run :doc:`your own designs<personal-designs>` using the F4PGA toolchain.
- :doc:`customize the Makefile<customizing-makefiles>` for your own designs.


About F4PGA
===========

F4PGA is a fully open source toolchain for the development of FPGAs, currently targeting chips from multiple vendors, e.g.:

- Xilinx's 7-Series.
- Lattice's ICE40 and ECP5.
- QuickLogic's EOS-S3.

Gain valuable information about the flows and the tools in section :ref:`Design Flows <f4pga:Flows>` at
:doc:`F4PGA Documentation <f4pga:index>`.


Table of Contents
=================

.. toctree::

   getting
   building-examples
   running-examples

.. toctree::
   :caption: Custom designs

   personal-designs
   customizing-makefiles

.. toctree::
   :caption: Additional example designs

   project-f
   basys3

.. toctree::
   :caption: Development

   development/building-docs
   development/running-ci-locally
