Part 2 Design G 
===============

This design strobes leds 0-3. 
To build this design run the following command in the main symbiflow directory:

.. code:: bash
   :name: hello-arty-G

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/G

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/G
