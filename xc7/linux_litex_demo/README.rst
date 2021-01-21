Linux LiteX demo
~~~~~~~~~~~~~~~~

This example design features a Linux-capable SoC based around VexRiscv soft
CPU. It also includes DDR and Ethernet controllers. To build the litex example,
run the following commands:

.. code-block:: bash
   :name: example-litex-deps

   wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
   chmod +x litex_setup.py
   ./litex_setup.py init
   ./litex_setup.py install
   wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
   tar -xf riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
   export PATH=$PATH:$PWD/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14/bin/
   cd litex-boards/litex_boards/targets
   ./arty.py --toolchain symbiflow --cpu-type vexriscv --build
   cd -

To build the linux-litex-demo example, depending on your hardware, run:

.. code-block:: bash
   :name: example-litex-a35t-group

   TARGET="arty_35" make -C linux_litex_demo

.. code-block:: bash
   :name: example-litex-a100t-group

   TARGET="arty_100" make -C linux_litex_demo

At completion, the bitstreams are located in the build directory:

.. code-block:: bash

   cd linux_litex_demo/build/<board>

Now you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

.. note::

   LiteX on Linux demo excepts you to use IPv4 address of ``192.168.100.100/24``
   on your network interface.

You should observe the following line in the OpenOCD output

.. code-block:: bash

   Info : JTAG tap: xc7.tap tap/device found: 0x0362d093 (mfg: 0x049 (Xilinx), part: 0x362d, ver: 0x0)

In the ``picocom`` terminal, you should observe the following output:

.. image:: ../../docs/images/linux-example-console.gif
   :align: center
   :width: 80%

Additionally, two LED's on the board should be turned on

.. image:: ../../docs/images/linux-example-arty.jpg
   :width: 49%
   :align: center
