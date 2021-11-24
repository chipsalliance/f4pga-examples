LiteX SATA demo
~~~~~~~~~~~~~~~

This example design features a Litex SoC based around VexRiscv soft
CPU. It also includes a DDR controller and a SATA core . To build the litex SATA example,
run the following commands:

To build the litex SATA demo example, first re-navigate to the directory that contains examples for Xilinx 7-Series FPGAs. Then depending on your hardware, run:


.. code-block:: bash
   :name: example-litex-sata-nexys-video-group

   TARGET="nexys_video" make -C litex_sata_demo

At completion, the bitstreams are located in the build directory:

.. code-block:: bash

   litex_sata_demo/build/<board>

