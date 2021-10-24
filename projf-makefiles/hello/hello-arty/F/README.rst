Part 2 Design F 
===============

This design blinks LEDs 0-3 at different frequencies. 
To build this design run the following command in the main symbiflow directory:

.. code:: bash
   :name: hello-arty-F

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/F

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/F
