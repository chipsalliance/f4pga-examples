Welcome to F4PGA examples!
==========================

This guide explains how to get started with F4PGA and build example designs
from the `F4PGA Examples <https://github.com/chipsalliance/f4pga-examples>`_
GitHub repository. It currently focuses on the following FPGA families:

- Artix-7 from Xilinx,
- EOS S3 from QuickLogic.

Follow this guide to:

- :doc:`install F4PGA <getting-symbiflow>` and all of its dependencies,
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
   :maxdepth: 2
   :caption: Sections

   getting-f4pga
   building-examples
   running-examples
   personal-designs
   customizing-makefiles
   understanding-commands
   project-f
