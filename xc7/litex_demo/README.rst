LiteX demo
~~~~~~~~~~

This example design features a LiteX+<CPU variant>-based SoC. It also includes DDR
controller. First, enter this example's directory:

.. code-block:: bash
   :name: example-litex-dir

   cd litex_demo

Install the litex dependencies with the following:

.. code-block:: bash
   :name: example-litex-req

   pip install -r requirements.txt
   
There are multiple CPU types supported, choose one from the below commands to generate the design and build it.

**Picorv32**

.. code-block:: bash
   :name: example-litex_picorv32-a35t-group

   ./arty.py --toolchain=symbiflow --cpu-type=picorv32 --sys-clk-freq 80e6 --uart-baudrate=1000000 --output-dir build/picorv32/arty_35 --board-variant a7-35 --build

.. code-block:: bash
   :name: example-litex_picorv32-a100t-group

   ./arty.py --toolchain=symbiflow --cpu-type=picorv32 --sys-clk-freq 80e6 --uart-baudrate=1000000 --output-dir build/picorv32/arty_100 --board-variant a7-100 --build

**VexRiscv**

.. code-block:: bash
   :name: example-litex_vexriscv-a35t-group

   ./arty.py --toolchain=symbiflow --cpu-type=vexriscv --sys-clk-freq 80e6 --uart-baudrate=1000000 --output-dir build/vexriscv/arty_35 --board-variant a7-35 --build

.. code-block:: bash
   :name: example-litex_vexriscv-a100t-group

   ./arty.py --toolchain=symbiflow --cpu-type=vexriscv --sys-clk-freq 80e6 --uart-baudrate=1000000 --output-dir build/vexriscv/arty_100 --board-variant a7-100 --build

Depending on which board and CPU-type you selected, the bitstream is loacted in:

.. code-block:: bash

   cd build/<cpu-type>/<board>/gateware

Now you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

.. note::

   This example uses baud rate of ``1000000`` by default.

You should observe the following line in the OpenOCD output

.. code-block:: bash

   Info : JTAG tap: xc7.tap tap/device found: 0x0362d093 (mfg: 0x049 (Xilinx), part: 0x362d, ver: 0x0)

In the ``picocom`` terminal, you should observe the following output:

.. image:: ../../docs/images/litex-picorv32-console.gif
   :align: center
   :width: 80%
