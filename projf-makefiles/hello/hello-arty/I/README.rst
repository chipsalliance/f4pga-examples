Part 2 Design I 
===============

This design allows you to control the brightness of each LED on the arty board using a PWM with different duty cycles. 
To build this design run the following command in the main f4pga directory:

.. code-block:: bash
   :name: hello-arty-i

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/I

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/I
