Button Debouncer
~~~~~~~~~~~~~~~~~~

This example demonstrates using a button debouncer state machine to count the number of presses on the center button
on the basys3 board. The number of presses will be given on the seven segment display. You can reset the button counter
by pressing the up button on the board. To build the design first navigate to the additional examples directory:

.. code-block:: bash
   :name: example-debouncer-basys3

   cd additional_examples

Then run make to compile the design: 

.. code-block:: bash
   :name: example-debouncer-basys3

   make -C button_debouncer


At completion, the bitstream is located in the build directory:

.. code-block:: bash

   cd button_debouncer/build/arty_35

Now, you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

The following is an example of the debouncer in action:

.. image:: ../images/debounce.gif
   :align: center
   :width: 50%


