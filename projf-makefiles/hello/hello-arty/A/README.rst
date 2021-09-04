Part 1 Design A 
===============

This design allows you to turn the first led on the arty board on and off by toggling switch 0. 
To build this design run the following command in main symbiflow directory:

.. code:: bash
   :name: hello-arty-A

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/A"

You can then find the bitstream under ``symbiflow-examples/hello-build/A``.
