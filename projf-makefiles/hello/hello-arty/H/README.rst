Part 2 Design H 
===============

This design controls the brightness of LEDs 0-3 by using a PWM. 
To build this design run the following command in the main f4pga directory:

.. code-block:: bash
   :name: hello-arty-h

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/H

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/H
