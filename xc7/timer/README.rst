Timer
~~~~~~

This example is built specifically for the basys3 and demonstrates a greater variety of I/O 
then previous designs. It also demonstrates symbiflow's support for code written in System Verilog 
as well as its support of dictionaries in XDCs. To build this example run the following commands:

.. code-block:: bash
   :name: example-watch-basys3

   make -C timer


At completion, the bitstream is located in the build directory:

.. code-block:: bash

   cd timer/build/basys3

Now, you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

After downloading the bitstream you can start and stop the watch by toggling switch 0 on the board.
Press the center button to reset the counter. The following gives a visual example:

.. image:: ../../docs/images/timer.gif
   :align: center
   :width: 50%


