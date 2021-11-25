LiteX SATA demo
~~~~~~~~~~~~~~~

This example design features a Litex SoC based around VexRiscv soft
CPU. It also includes a DDR controller and a SATA core.

The design targets the `Nexys Video <https://digilent.com/reference/programmable-logic/nexys-video/start>`_ board, mounting an Artix-7 200T FPGA,
and the `FMC adapter board <https://github.com/antmicro/fmc-sata-adapter>`_, mounting an M.2 SSD.

To build the litex SATA demo example, first re-navigate to the directory that contains examples for Xilinx 7-Series FPGAs. Then depending on your hardware, run:


.. code-block:: bash
   :name: example-litex-sata-nexys-video-group

   TARGET="nexys_video" make -C litex_sata_demo

At completion, the bitstreams are located in the build directory:

.. code-block:: bash

   litex_sata_demo/build/<board>

To generate the source files for this test, the following packages were used:

===========================================================  ========================================
Repo URL                                                     SHA
===========================================================  ========================================
`LiteX <https://github.com/enjoy-digital/litex>`_            95b310ee0f0d9e78e00eb32b71324b25265da4f4
`LiteSATA <https://github.com/enjoy-digital/litesata>`_      fae9f8d5b7b6d4c6a0a93b496bd15db5201d14f7
`LiteDRAM <https://github.com/enjoy-digital/litedram>`_      2c60861929a317af697267d6219da43d10dcf1fa
`LiteICLink <https://github.com/enjoy-digital/liteiclink>`_  0980a7cf4ffcb0b69a84fa0343a66180408b2a91
`LiteX Boards <https://github.com/litex-hub/litex-boards>`_  ea58ef94a784308ae024a1d201d603bc8459a590
`migen <https://github.com/m-labs/migen>`_                   c50ecdebd0e93c90ff44ca2e13d9f55fa97947d5
===========================================================  ========================================

The generated verilog design file (litesata.v) contains a couple of fixes to properly work with the Yosys+VPR flow.
The fixes are around the GTP high speed transceivers hard blocks.
