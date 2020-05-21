# SymbiFlow examples

This repository provides example FPGA designs that can be built using SymbiFlow open source toolchain.
The examples target the Artix-7 devices.

The repository includes:

* Travis CI configuration file
* Build scripts to generate the environment:
  * Conda configurations
  * Python requirements
  * Environment setup

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

## Setup Environment

By running the following command, the enviroment will be set up and ready to be used in order to run the examples.

```bash
make conda
```

The `conda` target internally does the following:

* Conda set up (from the `utils/conda.sh` script)

```bash
mkdir env
cd env
wget --no-verbose --continue https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
conda config --system --add envs_dirs env/conda/envs
conda config --system --add pkgs_dirs env/conda/pkgs
conda config --system --set always_yes yes
conda config --system --set changeps1 no
conda update -q conda
```

* Conda package install

```bash
conda env create --file ../conf/environment.yml
conda init bash
source ~/.bashrc
conda activate symbiflow-env
```

Note that the `environment.yml` configuration file contains all the conda packages that are going to be installed.


* Symbiflow toolchain download

```bash
wget -O symbiflow.tar.xz  <symbiflow archive URL>
tar -xf symbiflow.tar.xz -C env
rm symbiflow.tar.xz
```

Note that the tar archive is extracted in the `env` directory.

## Build Example Designs

The example designs are provided in separate directories:

1. `counter` - simple 4-bit counter driving LEDs. The design targets the [Basys3 board](https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/) .
2. `picosoc` - [picorv32](https://github.com/cliffordwolf/picorv32) based SoC. The design targets the [Basys3 board](https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/).
3. `linux_litex` - [LiteX](https://github.com/enjoy-digital/litex) based system with Linux capable [VexRiscv core](https://github.com/SpinalHDL/VexRiscv). The design includes [DDR](https://github.com/enjoy-digital/litedram) and [Ethernet](https://github.com/enjoy-digital/liteeth) controllers. The design targets the [Arty board](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/).

The Linux images for the `linux_litex` example can be build following the [linux on litex vexriscv](https://github.com/litex-hub/linux-on-litex-vexriscv) instructions.
The `linux_litex` example is already provided with working Linux images.

To build the examples, run following commands:

```bash
# This activates conda and sets the PATH env variable to include the SymbiFlow toolchain binaries
source env.sh

cd <example project>
make
```
