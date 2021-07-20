Serial Transmitter
~~~~~~~~~~~~~~~~~~~

This design demonstrates a UART transmitter on the basys3 board. ASKII values can be sent over USB to a 
putty terminal. To build the design first navigate to the additional_examples directory: 

.. code-block:: bash
   :name: additional-example

   cd additional_examples

Then run make to compile the design: 

.. code-block:: bash
   :name: example-uarttx-basys3

   make -C uart_transmitter


At completion, the bitstream is located in the build directory:

.. code-block:: bash
   :name: uarttx-build

   cd uart_transmitter/build/basys3

Now, you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

Once the code has been downloaded to the board open a Putty terminal and choose the correct serial 
connection line for your board from the list of options. Set the baud rate to 19200, data bits to 8, stop 
bits to 1, the parity to ODD, and the flow control to NONE. You can change these properties by looking under 
the serial settings on the left hand side of Putty. 

After configuring Putty, open a session and use the switches on the basys to chose an 
`ASKII <https://www.asciitable.com/>`_ character to send over UART. The value of the character will be 
displayed on the seven segment display in hexadecimal and you can send the character over UART by pressing 
the center button. The following is an example of the transmitter:

.. image:: ../images/uart_tx.gif
   :align: center
   :width: 50%


