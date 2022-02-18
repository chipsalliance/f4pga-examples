Part 1 Design A 
===============

This design allows you to turn the first led on the arty board on and off by toggling switch 0. 
To build this design run the following command in the main f4pga directory:

.. code-block:: bash
   :name: hello-arty-a

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/A

You can then download the bitstream by running:

.. code-block:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/A
