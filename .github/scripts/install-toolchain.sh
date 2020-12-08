#!/bin/bash
set -e

fpga_fam=$1

# create conda env
eval $(tuttest docs/getting-symbiflow.rst wget-conda 2>&1)
eval $(tuttest docs/getting-symbiflow.rst conda-install-dir 2>&1)
eval $(tuttest docs/getting-symbiflow.rst fpga-fam-$fpga_fam 2>&1)
eval $(tuttest docs/getting-symbiflow.rst conda-setup 2>&1)
eval $(tuttest docs/getting-symbiflow.rst download-arch-def-$fpga_fam 2>&1)
