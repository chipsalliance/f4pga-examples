LiteX PicoRV32 demo
~~~~~~~~~~~~~~~~~~~

This example design features a LiteX+PicoRV32-based SoC. It also includes DDR
controller. First, enter this example's directory:

.. code-block:: bash
   :name: example-litex_picorv32-dir

   cd picorv32_litex_demo

To generate the design yourself, run:

.. code-block:: bash
   :name: example-litex_picorv32-gen

   pip install -r requirements.txt
   wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
   tar -xf riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
   export PATH=$PATH:$PWD/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14/bin/
   src/litex/litex/boards/targets/arty.py --toolchain=symbiflow --cpu-type=picorv32 --sys-clk-freq 80e6 --uart-baudrate=115200 --build

To build the pregenerated design, depending on your hardware, run:

.. code-block:: bash
   :name: example-litex_picorv32-a35t-group

   TARGET="arty_35" make

.. code-block:: bash
   :name: example-litex_picorv32-a100t-group

   TARGET="arty_100" make

Now you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/conda/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 arty.bit; exit"

.. note::

   This example uses baud rate of ``115200`` by default.

You should observe the following line in the OpenOCD output

.. code-block:: bash

   Info : JTAG tap: xc7.tap tap/device found: 0x0362d093 (mfg: 0x049 (Xilinx), part: 0x362d, ver: 0x0)

In the ``picocom`` terminal, you should observe the following output:

.. image:: ../../docs/images/litex-picorv32-console.gif
   :align: center
   :width: 80%
