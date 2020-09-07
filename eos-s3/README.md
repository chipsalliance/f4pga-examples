# SymbiFlow Toolchain Examples for QuickLogic EOS S3

1. `btn_counter` - simple 4-bit counter driving LEDs. The design targets the [EOS S3 FPGA](https://www.quicklogic.com/products/eos-s3/).

## Setting up the toolchain

```bash
export INSTALL_DIR="/opt/symbiflow/eos-s3"
bash conda_installer.sh -b -p $INSTALL_DIR/conda && rm conda_installer.sh
source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
conda env create -f eos-s3/environment.yml
conda activate eos-s3
wget -qO- https://quicklogic-my.sharepoint.com/:u:/p/kkumar/Eb7341Bq-XRAukVQ6oQ6PrgB-qdFbrsrPEON1yTa4krFSA?download=1 | tar -xJ -C $INSTALL_DIR
cp -r $INSTALL_DIR/conda/envs/eos-s3/share/yosys/* $INSTALL_DIR/conda/envs/eos-s3/share/
conda deactivate
```

## Building the examples

To build the examples, run the following commands:

```bash
export INSTALL_DIR="/opt/symbiflow/eos-s3"
export PATH="$INSTALL_DIR/install/bin:$PATH"
source "$INSTALL_DIR/conda/etc/profile.d/conda.sh"
conda activate eos-s3

git clone https://github.com/SymbiFlow/symbiflow-examples && cd symbiflow-examples
pushd eos-s3/btn_counter && make && popd
```

