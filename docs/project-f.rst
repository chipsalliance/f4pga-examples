Running Project F designs in Symbiflow
======================================

.. warning::
   Symbiflow does not currently support the MMCME2_BASE primitive--a key commponent in Project F's 
   clock_gen_480p module and all designs involving video output. 
   As such, all of the designs in project F that require a display (all designs in FPGA graphics) will
   fail when run through the toolchain. Only the designs in 
   `Hello Arty <https://github.com/projf/projf-explore/tree/master/hello/hello-arty>`_ are currently 
   officially supported. To track the progress of the MMCME2_BASE see issue 
   `#153 <https://github.com/SymbiFlow/symbiflow-examples/issues/153>`_ in symbiflow examples and 
   issue `#2246 <https://github.com/SymbiFlow/symbiflow-arch-defs/issues/2246>`_ in arch-defs.
   One user was able to successfully run most of the display designs in project F by replacing the
   MMCM in clock_gen_480p.sv with a PLLE2_ADV. For details on that see issue 
   `#180 <https://github.com/SymbiFlow/symbiflow-examples/issues/180>`_ in symbiflow-examples.

Project F is an amazing repository containing many high quality FPGA example designs that show
some of the more impressive things you can do with an FPGA. You can find detailed documentation on
the designs and how they work on `the developers blog <https://projectf.io/sitemap/>`_. 

To build the Designs in Project F using symbiflow, first ensure that you have installed the Project F
submodule locally. Enter into the ``symbiflow-examples`` directory and run:

.. code-block:: bash
   :name: import-projectf

   git submodule update --init --recursive 

After installing the Submodules, you can run any supported design by calling its makefile:

.. code-block:: bash

   TARGET="<board type>" make -C projf-makefiles/<design module>/<design subset>/<design number or part name>

For example, to build the first design in project F's hello ary designs:

.. code-block:: bash

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/A

To download the bitstream to the board navigate to the generated bitstream and run openocd. 
For example to download the first design from hello arty:

.. code-block:: bash

   cd hello-build/A 
   openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 top.bit; exit"




