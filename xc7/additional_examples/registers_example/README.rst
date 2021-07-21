Registers
~~~~~~~~~~

This module implements eight 4-bit registers, one 3:8 decoder, and two 8:1 multiplexors to create a triple 
ported register file. This example also demonstrates testing a few of symbiflow's supported primitives.
To build the design first navigate to the additional_examples directory:

.. code-block:: bash
   :name: additional-example

   cd additional_examples

Then run make to compile the design: 

.. code-block:: bash
   :name: example-registers-basys3

   make -C registers_example


At completion, the bitstream is located in the build directory:

.. code-block:: bash
   :name: registers-build

   cd registers_example/build/basys3

Now, you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

Once the bitstream has been downloaded to the board, you can load different registers by toggling different 
switches on and off. Switches 0-4 on the basys define the binary value to be written to a specific register. 
The address of the register to be written to is defined by switches 4-6. Switches 4-6 also act as the first 
read address on the triple ported register file. Switches 6-9 define the second read address. The center 
button on the board is the write enable signal. The values being read are displayed on the basys3's seven 
segment display in hex with the value of Read out 1 displayed on the right most display and the value of 
read out 2 displayed on the left most. You can also manipulate the outputs of the register file by toggling 
the up and down buttons on the board. The up button adds the first and second read address together and 
displays the sum. The down button subtracts read address 1 from read address 2. The following is a visual 
of the register file in action.

.. image:: ../images/registers.gif
   :align: center
   :width: 50%




