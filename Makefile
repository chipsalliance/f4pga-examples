SHELL=bash

PWD=$(shell pwd)

SYMBIFLOW_ARCHIVE = symbiflow.tar.xz
SYMBIFLOW_URL = "https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/4/20200416-002215/symbiflow-arch-defs-install-a321d9d9.tar.xz"

conda:
	mkdir -p env
	source utils/conda.sh
	wget -O ${SYMBIFLOW_ARCHIVE} ${SYMBIFLOW_URL}
	tar -xf ${SYMBIFLOW_ARCHIVE} -C env
	rm ${SYMBIFLOW_ARCHIVE}
