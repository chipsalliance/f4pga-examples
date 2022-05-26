Button Controller
~~~~~~~~~~~~~~~~~

This example demonstrates using a button debouncer state machine to count the number of presses on the
center button of the basys3 board. The number of presses counted by the debouncer state machine will
be given on the two right most digits of the display. The two left most digits record the number of
presses counted without the debouncer. You can reset the button counter by pressing the up button on
the board. To build the design first navigate to the additional examples directory:

.. code-block:: bash
   :name: additional-examples

   cd additional_examples

Then run make to compile the design:

.. code-block:: bash
   :name: example-debouncer-basys3

   make -C button_controller


At completion, the bitstream is located in the build directory:

.. code-block:: bash

   cd button_controller/build/basys3

Now, you can upload the design with:

.. code-block:: bash

   openocd -f ${F4PGA_INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

The following is an example of the debouncer in action:

.. image:: ../images/debounce.gif
   :align: center
   :width: 50%
