Part 1 Design D 
===============

This design is the fourth design from Part 1 of Hello Arty. To build this design run the following 
command in the main symbiflow directory:

.. code:: bash
   :name: hello-arty-D

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/D"

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/D"
