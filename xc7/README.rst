F4PGA Toolchain Examples for Xilinx 7 Series
============================================

#. ``counter`` - simple 4-bit counter driving LEDs. The design targets the `Basys3 board <https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/>`__, the `Arty boards <https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/>`__, and the `Zybo Z7 board <https://store.digilentinc.com/zybo-z7-zynq-7000-arm-fpga-soc-development-board/>`__
#. ``picosoc`` - `picorv32 <https://github.com/cliffordwolf/picorv32>`__ based SoC. The design targets the `Basys3 board <https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/>`__.
#. ``litex`` - Series of `LiteX-based <https://github.com/enjoy-digital/litex>`__ designs, that feature different CPU types and LiteX modules.
#. ``linux_litex`` - `LiteX <https://github.com/enjoy-digital/litex>`__ based system with Linux capable `VexRiscv core <https://github.com/SpinalHDL/VexRiscv>`__. The design includes `DDR <https://github.com/enjoy-digital/litedram>`__ and `Ethernet <https://github.com/enjoy-digital/liteeth>`__ controllers. The design targets the `Arty boards <https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/>`__.

The Linux images for the ``linux_litex`` example can be built following the `linux on litex vexriscv <https://github.com/litex-hub/linux-on-litex-vexriscv>`__ instructions.
The ``linux_litex`` example is already provided with working Linux images.

The detailed description about building the examples is available in the
`project documentation <https://f4pga-examples.readthedocs.io/en/latest/building-examples.html#xilinx-7-series>`__.
