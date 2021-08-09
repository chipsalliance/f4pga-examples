Bouncing Squares
================

This design is targeted for the Basys3 board and comes from the designs in 
`Project F <https://projectf.io/about/>`_. When the board is connected to a display though a VGA cable 
three squares one red, one green, and one blue are displayed on screen. The squares bounce around 
the display their colors mix as they collide with each other. More detailed documentation can be 
found on `this blog page <https://projectf.io/posts/fpga-graphics/>`_ from Project F.

Change Notes
------------

In order to make this design compatible with symbiflow, several changes were made to the clock_gen_480p
module. The original design used an MMCME2_BASE primitive to generate a 25.2 MHz pixel clock. Since 
the MMCME2_BASE is not currently supported by symbiflow, a PLLE2_ADV was used instead. The values for 
the clock multipliers and dividers were also changed slightly to accommodate the change. You can find 
the original clock_gen file in this directory under clock_gen_480p-original.sv. Additionally, an 
xdc for the basys3 board was added to the project. 