Part 1 Design B 
===============

This design allows you to turn four LEDs on and off with switches 0 and 1. Control LEDs 0 and 1 with switch 0 and LEDs
2 and 3 with switch 1. To build this design run the following in the root f4pga-example directory:

.. code-block:: bash
   :name: hello-arty-b

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/B

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/B
