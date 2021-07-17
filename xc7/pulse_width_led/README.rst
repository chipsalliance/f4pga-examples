Stop Watch
~~~~~~~~~~~~

This example is built specificity for the arty_35T and demonstrates a greater variety of I/O and 
demonstrates a PWM that drives the RGB leds on the board. To build this example run the following
commands:

.. code-block:: bash
   :name: example-pulse-arty-35t

   make -C pulse_width_led


At completion, the bitstreams are located in the build directory:

.. code-block:: bash

   cd stop_watch/build/arty_35

Now, you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"

After downloading the bitstream, you can control the color of RGB led 0 by toggling different 
switches and buttons on and off. From left to right: switches 3,2,1 control the amount of blue, 
switch 0 and buttons 3 and 2 control the amount of red, and buttons 1 and 0 control the amount of 
green. The following provides an example:

.. image:: ../../docs/images/pwm.gif
   :align: center
   :width: 50%


