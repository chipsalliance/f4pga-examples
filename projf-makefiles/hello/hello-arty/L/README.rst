Part 3 Design L 
===============

This is the second part of the traffic light example from project F. 
To build this design run the following command in the main f4pga directory:

.. code-block:: bash
   :name: hello-arty-l

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/L

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/L
