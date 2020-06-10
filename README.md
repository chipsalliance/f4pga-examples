# SymbiFlow examples

This repository provides example FPGA designs that can be built using the SymbiFlow open source toolchain.
The examples target the Xilinx Artix-7 and the QuickLogic EOS S3 devices.

The repository includes:

* [examples](./examples) - Example FPGA designs including:

  * Verilog code
  * Pin constraints files
  * Timing constraints files
  * Makefiles for running the SymbiFlow toolchain

* [.travis.yml](.travis.yml) - Travis CI configuration file

## Toolchain installation

This section describes how to install the toolchain. This procedure is divided in two steps:

- Installing the Conda package manager
- Downloading the architecture definitions and installing the toolchain

1. Conda

```bash
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda_installer.sh
```

2. Toolchain

For the Artix-7 devices:

```bash
INSTALL_DIR="/opt/symbiflow/xc7"
bash conda_installer.sh -b -p $INSTALL_DIR/conda && rm conda_installer.sh
source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
conda update -y -q conda

wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/4/20200416-002215/symbiflow-arch-defs-install-a321d9d9.tar.xz | tar -xJ -C $INSTALL_DIR
conda install -y -c symbiflow yosys yosys-plugins vtr-no-gui
conda install -y make lxml simplejson intervaltree git pip
conda activate
pip install python-constraint
pip install git+https://github.com/symbiflow/fasm
conda deactivate
```

For the EOS S3 devices:

```bash
INSTALL_DIR="/opt/symbiflow/eos-s3"
bash conda_installer.sh -b -p $INSTALL_DIR/conda && rm conda_installer.sh
source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
conda update -y -q conda

wget -qO- https://storage.googleapis.com/symbiflow-arch-defs-install/quicklogic/arch-defs-install-eos-s3-f7880e1f.tar.xz | tar -xJ -C $INSTALL_DIR
conda install -y -c antmicro/label/ql yosys yosys-plugins vtr-no-gui
conda install -y make lxml simplejson intervaltree git pip
conda activate
pip install python-constraint
pip install git+https://github.com/symbiflow/fasm
pip install git+https://github.com/antmicro/quicklogic-fasm
pip install git+https://github.com/antmicro/quicklogic-fasm-utils
conda deactivate
```

## Build Example Designs

With the toolchain installed, you can build the example designs.
The example designs are provided in separate directories:

* `examples/xc7` directory for the Artix-7 devices
* `examples/eos-s3` directory for the EOS S3 devices

### Example designs for the Artix-7 devices:

1. `counter` - simple 4-bit counter driving LEDs. The design targets the [Basys3 board](https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/) and the [Arty board](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/).
1. `picosoc` - [picorv32](https://github.com/cliffordwolf/picorv32) based SoC. The design targets the [Basys3 board](https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/).
1. `linux_litex` - [LiteX](https://github.com/enjoy-digital/litex) based system with Linux capable [VexRiscv core](https://github.com/SpinalHDL/VexRiscv). The design includes [DDR](https://github.com/enjoy-digital/litedram) and [Ethernet](https://github.com/enjoy-digital/liteeth) controllers. The design targets the [Arty board](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/).

The Linux images for the `linux_litex` example can be built following the [linux on litex vexriscv](https://github.com/litex-hub/linux-on-litex-vexriscv) instructions.
The `linux_litex` example is already provided with working Linux images.

To build the examples, run the following commands:

```bash
export INSTALL_DIR="/opt/symbiflow/xc7"
# adding symbiflow toolchain binaries to PATH
export PATH="$INSTALL_DIR/install/bin:$PATH"
source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
conda activate
git clone https://github.com/SymbiFlow/symbiflow-examples && cd symbiflow-examples
# counter example
pushd examples/xc7/counter_test && TARGET="arty" make && popd
pushd examples/xc7/counter_test && make clean && TARGET="basys3" make && popd
# picosoc example
pushd examples/xc7/picosoc_demo && make && popd
# litex example
pushd examples/xc7/linux_litex_demo && make && popd
```

### Example design for the EOS S3 devices:

1. `btn_counter` - simple 4-bit counter driving LEDs. The design targets the [EOS S3 FPGA](https://www.quicklogic.com/products/eos-s3/).

To build the example, run the following commands:

```bash
export INSTALL_DIR="/opt/symbiflow/eos-s3"
# adding symbiflow toolchain binaries to PATH
export PATH="$INSTALL_DIR/install/bin:$PATH"
source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
conda activate
git clone https://github.com/SymbiFlow/symbiflow-examples && cd symbiflow-examples
pushd examples/eos-s3 && make && popd
```
