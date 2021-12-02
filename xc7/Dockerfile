FROM ubuntu:18.04

 # RISC-V toolchain
RUN apt-get update && apt-get install -y software-properties-common make verilog autoconf automake autotools-dev curl libmpc-dev \
    libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo \
    gperf libtool patchutils bc zlib1g-dev git libexpat1-dev

RUN mkdir /opt/riscv32i \
&& git clone https://github.com/riscv/riscv-gnu-toolchain riscv-gnu-toolchain-rv32i \
&& cd riscv-gnu-toolchain-rv32i \
&& git checkout 411d134 \
&& git submodule update --init --recursive

RUN cd riscv-gnu-toolchain-rv32i && mkdir build \
&& cd build \
&& ../configure --with-arch=rv32i --prefix=/opt/riscv32i \
&& make -j$(nproc)

ENV PATH="$PATH:/opt/riscv32i/bin"

# Symbilflow

ARG INSTALL_DIR=/root/opt/symbiflow
ARG FPGA_FAM=xc7

ENV PATH="$PATH:/root/miniconda3/bin"
ENV PATH="$PATH:$INSTALL_DIR/$FPGA_FAM/install/bin"

RUN apt-get update && apt-get install -y git wget xz-utils make

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

RUN mkdir -p $INSTALL_DIR

COPY $FPGA_FAM/environment.yml $FPGA_FAM/requirements.txt /$INSTALL_DIR/
RUN conda env create -f $INSTALL_DIR/environment.yml

COPY $FPGA_FAM/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]


