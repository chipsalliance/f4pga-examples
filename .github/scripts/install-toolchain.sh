#!/bin/bash

set -e

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${CURRENT_DIR}/common.sh

# -- validate input -----------------------------------------------------------

function help() {
   echo
   echo "Install the SymbiFlow toolchain as described in the sphinx documentation"
   echo
   echo "Syntax: $0 fpga_family os"
   echo "Arguments:"
   echo "  fpga_family  - A supported FPGA family"
   echo "  os           - A supported operating system"
   echo
}

if [[ ! $# -eq 2 ]]; then
  echo "ERROR: Invalid number of arguments"
  help
  exit 1
fi

# -- tuttest ------------------------------------------------------------------

fpga_family=$1
os=$2

tuttest_exec docs/getting-symbiflow.rst install-reqs-$os
tuttest_exec docs/getting-symbiflow.rst wget-conda
tuttest_exec docs/getting-symbiflow.rst conda-install-dir
tuttest_exec docs/getting-symbiflow.rst fpga-fam-$fpga_family
tuttest_exec docs/getting-symbiflow.rst conda-setup
tuttest_exec docs/getting-symbiflow.rst download-arch-def-$fpga_family
