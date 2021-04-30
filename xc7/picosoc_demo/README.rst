PicoSoC demo
~~~~~~~~~~~~

This example features a picorv32 soft CPU and a SoC based on it. To build the
picosoc example, run the following commands:

.. code-block:: bash
   :name: example-picosoc-a35t-group

   TARGET="arty_35" make -C picosoc_demo


.. code-block:: bash
   :name: example-picosoc-a100t-group

   TARGET="arty_100" make -C picosoc_demo


.. code-block:: bash
   :name: example-picosoc-nexys4ddr-group

   TARGET="nexys4ddr" make -C picosoc_demo


.. code-block:: bash
   :name: example-picosoc-basys3-group

   TARGET="basys3" make -C picosoc_demo

At completion, the bitstreams are located in the build directory:

.. code-block:: bash

   cd picosoc_demo/build/<board>

Now you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"


You should observe the following line in the OpenOCD output:

.. code-block::

   Info : JTAG tap: xc7.tap tap/device found: 0x0362d093 (mfg: 0x049 (Xilinx), part: 0x362d, ver: 0x0)

The UART output should look as follows:

.. code-block::

   Terminal ready
   Press ENTER to continue..
   Press ENTER to continue..
   Press ENTER to continue..
   Press ENTER to continue..

    ____  _          ____         ____
   |  _ \(_) ___ ___/ ___|  ___  / ___|
   | |_) | |/ __/ _ \___ \ / _ \| |
   |  __/| | (_| (_) |__) | (_) | |___
   |_|   |_|\___\___/____/ \___/ \____|


   [9] Run simplistic benchmark

   Command>

.. note::

   PicoSoC uses baud rate of ``460800`` by default.

.. note::

   On the Nexys4DDR, the USB-UART does not work, so UART can be accessed from pins 1 and 2 of PMOD C.

The board's LED should blink at a regular rate from left to the right

.. image:: ../../docs/images/picosoc-example-basys3.gif
   :width: 49%
   :align: center
