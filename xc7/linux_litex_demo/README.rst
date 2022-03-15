Linux LiteX demo
~~~~~~~~~~~~~~~~

This example design features a Linux-capable SoC based around VexRiscv soft CPU.
It also includes DDR and Ethernet controllers.
To build the litex example, run the following commands:

To build the linux-litex-demo example, first re-navigate to the directory that contains examples for Xilinx 7-Series
FPGAs.
Then, depending on your hardware, run:

.. code-block:: bash
   :name: example-litex-a35t-group

   TARGET="arty_35" make -C linux_litex_demo

.. code-block:: bash
   :name: example-litex-a100t-group

   TARGET="arty_100" make -C linux_litex_demo

At completion, the bitstreams are located in the build directory:

.. code-block:: bash

   linux_litex_demo/build/<board>

Now you can upload the design with:

.. code-block:: bash

   TARGET="<board type>" make download -C linux_litex_demo

.. note::

   The LiteX design is provided with an Ethernet module that uses the ``192.168.100.100/24``
   IPv4 address that needs to be set on your network interface.

   You may find these information useful to correctly setup the network interface: `timvideos/litex-buildenv/wiki/Networking <https://github.com/timvideos/litex-buildenv/wiki/Networking>`__.

You should observe the following line in the OpenOCD output:

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
