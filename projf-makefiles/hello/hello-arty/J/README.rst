Part 2 Design J 
===============

This design controls the color of each of the 4 RGB LEDs on the arty using a PWM. 
To build this design run the following command in the main f4pga directory:

.. code-block:: bash
   :name: hello-arty-j

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/J

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/J
