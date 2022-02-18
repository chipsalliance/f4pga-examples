Part 1 Design C
===============

This design has the same functionality in hardware as part C but demonstrates
the use of conditional operators in System Verilog. To build this design run the 
following command in the main f4pga directory:

.. code-block:: bash
   :name: hello-arty-c

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/C

You can then download the bitstream by running:

.. code:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/C
