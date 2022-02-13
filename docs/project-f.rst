Running Project F designs in F4PGA
==================================

.. warning::
   F4PGA does not currently support the MMCME2_BASE primitive--a key commponent in Project F's clock_gen_480p module
   and all designs involving video output.
   As such, all of the designs in project F that require a display (all designs in FPGA graphics) will fail when run
   through the toolchain. Only the designs in :gh:`Hello Arty <projf/projf-explore/tree/master/hello/hello-arty>` are
   currently officially supported.
   To track the progress of the MMCME2_BASE see :ghissue:`153` and issue :gh:`chipsalliance/f4pga-arch-defs#2246 <chipsalliance/f4pga-arch-defs/issues/2246>`.
   One user was able to successfully run most of the display designs in project F by replacing the MMCM in
   ``clock_gen_480p.sv`` with a PLLE2_ADV.
   For details on that see :ghissue:`180` in f4pga-examples.

Project F is an amazing repository containing many high quality FPGA example designs that show
some of the more impressive things you can do with an FPGA. You can find detailed documentation on
the designs and how they work on `the developers blog <https://projectf.io/sitemap/>`_.

To build the Designs in Project F using F4PGA, first ensure that you have installed the Project F
submodule locally. Enter into the ``f4pga-examples`` directory and run:

.. code-block:: bash
   :name: import-projectf

   git submodule update --init --recursive

After installing the Submodules, you can run any supported design by calling its makefile:

.. code-block:: bash

   TARGET="<board type>" make -C projf-makefiles/<design module>/<design subset>/<design number or part name>

For example, to build the first design in project F's hello ary designs:

.. code-block:: bash

   TARGET="arty_35" make -C projf-makefiles/hello/hello-arty/A

To download the bitstream to the board run ``make download``.
For example, to download the first design from hello arty, run the following in F4PGA's root directory:

.. code-block:: bash

   TARGET="arty_35" make download -C projf-makefiles/hello/hello-arty/A
