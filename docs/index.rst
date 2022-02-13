Welcome to F4PGA examples!
==========================

This guide explains how to get started with F4PGA and build example designs from the :gh:`F4PGA Examples <chipsalliance/f4pga-examples>`
GitHub repository.
It currently focuses on the following FPGA families:

- Artix-7 from Xilinx,
- EOS S3 from QuickLogic.

Follow this guide to:

- :doc:`install F4PGA <getting>` and all of its dependencies,
- :doc:`build <building-examples>` and :doc:`upload <running-examples>`
  example designs onto the devboard of your choice.
- compile and run :doc:`your own designs<personal-designs>` using the F4PGA toolchain.
- :doc:`customize the Makefile<customizing-makefiles>` for your own designs.
- gain valuable information about `Understanding Toolchain Commands in F4PGA <understanding-commands.html>`_


About F4PGA
-----------

F4PGA is a fully open source toolchain for the development of FPGAs,
currently targeting chips from multiple vendors, e.g.:

- Xilinx 7-Series
- Lattice iCE40
- Lattice ECP5 FPGAs
- QuickLogic EOS S3

.. toctree::

   getting
   understanding-commands

.. toctree::
   :caption: Example designs

   building-examples
   running-examples

.. toctree::
   :caption: Custom designs

   personal-designs
   customizing-makefiles

.. toctree::
   :caption: Additional example designs

   project-f
