Part 2 Design E 
===============

This is the first design in Hello Arty part 2. This design blinks LED 0. 
To build this design run the following command in the main f4pga directory:

.. code-block:: bash
   :name: hello-arty-e

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/E

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/E
