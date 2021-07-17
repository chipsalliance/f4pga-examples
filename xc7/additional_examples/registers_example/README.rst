Registers
~~~~~~~~~~

This module implements eight 4-bit registers, one
3:8 decoder, and two 8:1 multiplexors to create a triple ported
register file. This example also demonstrates symbiflows ability to parse a combination of verilog and system verilog files together as well as testing a few primitives.


.. code-block:: bash
   :name: additional-example

   cd additional_examples

Then run make to compile the design: 

.. code-block:: bash
   :name: example-registers-basys3

   make -C uart_receiver


At completion, the bitstream is located in the build directory:

.. code-block:: bash

   cd uart_receiver/build/arty_35

Now, you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

Once the bitstream has been downloaded to the board, you can load different registers by toggling different switches on and off. Switches 0-4 on the basys define the binary value 
to be written to the register speciefied by switches 4-6. Switches 4-6 also act as the first read address on the triple ported register file. 
switches 6-9 define the second read address. The center button on the board is the write 
enable signal. The value being read is displayed on the basys3's seven segment display in hex.
You can chose to display the first or second btnl and the values of reg 1 and 2 together, btnu-reg2+reg1, btnd-reg1-reg2. The value 
you chose will be output o the first segment of the basys board.

.. image:: ../images/registers.gif
   :align: center
   :width: 50%


