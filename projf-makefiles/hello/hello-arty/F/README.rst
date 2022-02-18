Part 2 Design F 
===============

This design blinks LEDs 0-3 at different frequencies. 
To build this design run the following command in the main f4pga directory:

.. code-block:: bash
   :name: hello-arty-f

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/F

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/F
