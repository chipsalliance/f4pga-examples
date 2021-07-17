UART Receiver
~~~~~~~~~~~~~~~~~~

This UART receiver on the basys3 board. 

.. code-block:: bash
   :name: additional-example

   cd additional_examples

Then run make to compile the design: 

.. code-block:: bash
   :name: example-uarttx-basys3

   make -C uart_receiver


At completion, the bitstream is located in the build directory:

.. code-block:: bash

   cd uart_receiver/build/arty_35

Now, you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

Once the code has been downloaded to the board open a Putty terminal and choose the serial connection line for your board. 
Also set the baud rate to 19200, data bits to 8, stop bits to 1, the parity to ODD, and the flow control to NONE. You can 
change these properties by looking under the serial settings on the left hand side. 

After configuring Putty, open a session and type some characters. The ASKII values of the keys you press will be displayed 
on the basys3 board in hex. The LEDs are used to notify of any reception errors. You can also transmit ASKII characters to putty 
by following the same procedures as in the uart_receiver example. The following is an example of the receiver:

.. image:: ../images/uart_tx.gif
   :align: center
   :width: 50%


