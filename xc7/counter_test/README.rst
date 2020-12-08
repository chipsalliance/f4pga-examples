Counter test
~~~~~~~~~~~~

This example design features a simple 4-bit counter driving LEDs. To build the
counter example, depending on your hardware, run:

.. code-block:: bash
   :name: example-counter-a35t-group

   TARGET="arty_35" make -C counter_test


.. code-block:: bash
   :name: example-counter-a100t-group

   TARGET="arty_100" make -C counter_test


.. code-block:: bash
   :name: example-counter-basys3-group

   TARGET="basys3" make -C counter_test

Now you can upload the design with:

.. code-block:: bash

   openocd -f ${INSTALL_DIR}/conda/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"


The result should be as follows:

.. image:: ../../docs/images/counter-example-arty.gif
   :align: center
   :width: 50%
