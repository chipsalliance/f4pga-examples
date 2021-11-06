Pulse Width
~~~~~~~~~~~~


This example is built specificity for the arty_35T. It demonstrates a greater variety of I/O and 
a PWM that drives the RGB leds on the board. To build this example run the following
commands:

.. code-block:: bash
   :name: example-pulse-arty-35t

   make -C pulse_width_led


At completion, the bitstreams are located in the build directory:

.. code-block:: bash

   pulse_width_led/build/arty_35

Now, you can upload the design with:

.. code-block:: bash

   TARGET="arty_35" make download -C pulse_width_led

After downloading the bitstream, you can experiment with and mix different amounts of red, green, and 
blue on RGB led 0 by toggling different switches and buttons on and off. From left to right: 
switches 3, 2, 1 control the intensity of blue, switch 0 and buttons 3 and 2 control the intensity of 
red, and buttons 1 and 0 control the intensity of green. The following provides an example:

.. image:: ../../docs/images/pwm.gif
   :align: center
   :width: 50%


