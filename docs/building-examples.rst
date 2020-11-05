Building example designs
========================

Before building any example, set the installation directory to match what you
set it to earlier, for example:

.. code-block:: bash

    export INSTALL_DIR=~/opt/symbiflow

Select your fpga family:

.. tabs::

    .. group-tab:: Artix-7

        .. code-block:: bash
        
            FPGA_FAM="xc7"

    .. group-tab:: EOS S3

        .. code-block:: bash

            FPGA_FAM="eos-s3"

Next, prepare the enviroment:

.. code-block:: bash

    export PATH="$INSTALL_DIR/$FPGA_FAM/install/bin:$PATH"
    source "$INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh"

Finally, enter your working Conda enviroment:

.. code-block:: bash

    conda activate $FPGA_FAM

.. note::

    If you don't know how to upload any of the following examples onto your
    development board, please refer to the Running examples section.


Xilinx 7-Series
---------------

Enter the directory that contains examples for Xilinx 7-Series FPGAs:

.. code-block:: bash

    cd examples/xc7

Counter test
~~~~~~~~~~~~

This example design features a simple 4-bit countrer driving LEDs. To build the
counter example, run the following command:

.. tabs::

    .. group-tab:: Arty 35T

        .. code-block:: bash

            TARGET="arty_35" make -C counter_test

    .. group-tab:: Arty 100T

        .. code-block:: bash

            TARGET="arty_100" make -C counter_test

    .. group-tab:: Basys 3

        .. code-block:: bash

            TARGET="basys3" make -C counter_test

Now you can upload the design with:

.. code-block:: bash

    openocd -f ${INSTALL_DIR}/conda/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"


The result should be as follows:

.. image:: images/counter-example-arty.gif
    :align: center

PicoSoC demo
~~~~~~~~~~~~

This example features a picorv32 soft CPU and a SoC based on it. To build the
picosoc example, run the following commands:

.. tabs::

    .. group-tab:: Basys 3

        .. code-block:: bash

            TARGET="basys3" make -C picosoc_demo

Now you can upload the design with:

.. code-block:: bash

    openocd -f ${INSTALL_DIR}/conda/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"


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

The board's LED should blink at a regular rate from left to the right

 .. image:: images/picosoc-example-basys3.gif
    :width: 49%
    :align: center

Linux LiteX demo
~~~~~~~~~~~~~~~~

This example design features a Linix-capable SoC based around VexRiscv soft
CPU. It also includes DDR and Ethernet controllers. To build the litex example,
run the following commands:

.. code-block:: bash
   :name: xc7-litex

   wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
   chmod +x litex_setup.py
   ./litex_setup.py init
   ./litex_setup.py install
   wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
   tar -xf riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
   export PATH=$PATH:$PWD/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14/bin/
   pushd litex/litex/boards/targets && ./arty.py --toolchain symbiflow --cpu-type vexriscv --build && popd

To build the linux-litex-demo example, run the following commands:

.. tabs::

    .. group-tab:: Arty 35T

        .. code-block:: bash

            TARGET="arty_35" make -C litex_linux_demo

    .. group-tab:: Arty 100T

        .. code-block:: bash

            TARGET="arty_100" make -C litex_linux_demo

Now you can upload the design with:

.. code-block:: bash

    openocd -f ${INSTALL_DIR}/conda/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

.. note::

    LiteX on Linux demo excepts you to use IPv4 address of ``192.168.100.100/24``
    on your network interface.

You should observe the following line in the OpenOCD output

.. code-block:: bash

   Info : JTAG tap: xc7.tap tap/device found: 0x0362d093 (mfg: 0x049 (Xilinx), part: 0x362d, ver: 0x0)

In the ``picocom`` terminal, you should observe the following output:

.. image:: images/linux-example-console.gif
   :align: center
   :width: 80%

Additionally, two LED's on the board should be turned on

.. image:: images/linux-example-arty.jpg
   :width: 49%
   :align: center

QuickLogic EOS S3
-----------------

Enter the directory that contains examples for QuickLogic EOS S3:

.. code-block:: bash

    cd examples/eos-s3

Button counter
~~~~~~~~~~~~~~

This example design features a simple 4-bit countrer driving LEDs. To build the
counter example, run the following command:

.. code-block:: bash
   :name: eos-s3-counter

   make -C btn_counter
