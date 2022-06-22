Button counter
~~~~~~~~~~~~~~

This example design features a simple 4-bit counter driving LEDs. To build the
counter example, run the following command:

.. code-block:: bash
   :name: eos-s3-counter

   #FIXME: make sure FPGA_FAM is available and remove env var export
   export FPGA_FAM=eos-s3
   make -C btn_counter
