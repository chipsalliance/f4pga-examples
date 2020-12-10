#!/bin/bash

set -e

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${CURRENT_DIR}/common.sh

# -- validate input ----------------------------------------------------------

function help() {
   echo
   echo "Build examples from the repository"
   echo
   echo "Syntax: $0 fpga_family [examples]..."
   echo "Arguments:"
   echo "  fpga_family  - A supported FPGA family"
   echo "  examples     - A name of an available example"
   echo
}

if [[ ! $# -ge 1 ]]; then
  echo "Invalid number of arguments!"
  help
  exit 1
fi

# -- tuttest -----------------------------------------------------------------

fpga_family=$1
shift

examples="$@"
if [ "$fpga_family" == "xc7" -a -z "$examples" ]; then
    examples="counter picosoc litex_linux"
elif [ "$fpga_family" == "eos-s3" -a -z "$examples" ]; then
    examples="counter"
fi

# activate conda and enter example dir
tuttest_exec docs/building-examples.rst export-install-dir
tuttest_exec docs/building-examples.rst fpga-fam-$fpga_family
tuttest_exec docs/building-examples.rst conda-prep-env
tuttest_exec docs/building-examples.rst conda-act-env
tuttest_exec docs/building-examples.rst enter-dir-$fpga_family

# Xilinx 7-Series examples
if [ "$fpga_family" = "xc7" ]; then
    for example in $examples; do
        case $example in
            "counter")
                tuttest_exec xc7/counter_test/README.rst example-counter-*-group
                ;;
            "picosoc")
                tuttest_exec xc7/picosoc_demo/README.rst example-picosoc-*-group
                ;;
            "litex_linux")
                tuttest_exec xc7/linux_litex_demo/README.rst example-litex-deps
                tuttest_exec xc7/linux_litex_demo/README.rst example-litex-*-group
                ;;
             *)
                echo "ERROR: Unknown example name: $example"
                exit 1
                ;;
        esac
    done
# QuickLogic EOS-S3 examples
elif [ "$fpga_family" = "eos-s3" ]; then
    for example in $examples; do
        case $example in
            "counter")
                tuttest eos-s3/btn_counter/README.rst eos-s3-counter
                ;;
             *)
                echo "ERROR: Unknown example name: $example"
                exit 1
                ;;
        esac
    done
else
  echo "ERROR: Unknown fpga_family: $fpga_family"
fi
