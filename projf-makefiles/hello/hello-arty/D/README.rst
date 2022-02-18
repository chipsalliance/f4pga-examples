Part 1 Design D 
===============

This design is the fourth design from Part 1 of Hello Arty. To build this design run the following 
command in the main f4pga directory:

.. code-block:: bash
   :name: hello-arty-d

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/D

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/D
