Part 2 Design J 
===============

This design controls the color of each of the 4 RGB LEDs on the arty using a PWM. 
To build this design run the following command in the main symbiflow directory:

.. code:: bash
   :name: hello-arty-J

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/J

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/J
