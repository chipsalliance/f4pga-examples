# SymbiFlow examples

This repository provides example FPGA designs that can be built using SymbiFlow open source toolchain.
The examples target the Artix-7 devices.

The repository includes:

* Travis CI configuration file
* Example FPGA designs including:

  * Verilog code
  * Pin constraints files
  * Timing constraints files
  * Makefiles for running the SymbiFlow toolchain 

## Description

Travis-based CI in this repository runs all the steps required to build the example designs and generate bitstreams for programming the FPGA devices.

The CI performs the following steps:

* [Miniconda](https://docs.conda.io/en/latest/miniconda.html) installation and configuration 
* Installation of the required conda packages (toolchains and Python modules). Note that Python packages can be installed using any Python package manager:

    * [VTR](https://anaconda.org/symbiflow/vtr)
    * [Yosys](https://anaconda.org/symbiflow/yosys)
    * [Yosys-plugins](https://anaconda.org/symbiflow/yosys-plugins)
    * [lxml](https://anaconda.org/conda-forge/lxml), [simplejson](https://anaconda.org/conda-forge/simplejson), [intervaltree](https://anaconda.org/conda-forge/intervaltree), [python-constraint](https://anaconda.org/conda-forge/python-constraint), [git](https://anaconda.org/conda-forge/git), [pip](https://anaconda.org/conda-forge/pip) and [fasm](https://github.com/SymbiFlow/fasm)

* Building of example designs

The example designs are provided in separate directories:

1. `counter` - simple 4-bit counter driving LEDs. The design targets the [Basys3 board](https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/) .
1. `picosoc` - [picorv32](https://github.com/cliffordwolf/picorv32) based SoC. The design targets the [Basys3 board](https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/).
1. `linux_litex` - [LiteX](https://github.com/enjoy-digital/litex) based system with Linux capable [VexRiscv core](https://github.com/SpinalHDL/VexRiscv). The design includes [DDR](https://github.com/enjoy-digital/litedram) and [Ethernet](https://github.com/enjoy-digital/liteeth) controllers. The design targets the [Arty board](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/).

The Linux images for the `linux_litex` example can be build following the [linux on litex vexriscv](https://github.com/litex-hub/linux-on-litex-vexriscv) instructions.

The Travis-based CI performs all the necessary steps to build the example designs and generate the bitstreams.
If you want to manually build the examples, run following commands:

```bash
git clone https://github.com/SymbiFlow/symbiflow-examples.git
cd symbiflow-examples
git submodule update --init --recursive
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
source "$HOME/miniconda/etc/profile.d/conda.sh"
conda config --set always_yes yes --set changeps1 no
conda update -q conda
conda env create --file $PWD/conf/environment.yml
conda init bash
source ~/.bashrc
conda activate symbiflow-examples-env
wget "https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/11/20200519-183311/symbiflow-arch-defs-install-ccb38aa3.tar.xz"
tar -xf symbiflow-arch-defs-install-ccb38aa3.tar.xz
pushd third_party/prjxray
make build -j`nproc`
popd
export PATH=$PWD/install/bin:$PATH
export XRAY_DATABASE_DIR=$PWD/third_party/prjxray-db
export XRAY_FASM2FRAMES=$PWD/third_party/prjxray/utils/fasm2frames.py
export XRAY_TOOLS_DIR=$PWD/third_party/prjxray/build/tools
# counter example
pushd counter_test && make && popd
# picosoc example
pushd picosoc_demo && make && popd
# litex example
pushd linux_litex_demo && make && popd
```
