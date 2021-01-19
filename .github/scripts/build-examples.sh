#!/bin/bash
#
# Copyright (C) 2020  The SymbiFlow Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

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

snippets="export-install-dir,fpga-fam-$fpga_family,conda-prep-env,conda-act-env,enter-dir-$fpga_family"

# Xilinx 7-Series examples
if [ "$fpga_family" = "xc7" ]; then
    for example in $examples; do
        case $example in
            "counter")
                snippets="${snippets},example-counter-*-group"
                ;;
            "picosoc")
                snippets="${snippets},xc7/picosoc_demo/README.rst,example-picosoc-*-group"
                ;;
            "litex_linux")
                snippets="${snippets},xc7/linux_litex_demo/README.rst,example-litex-deps,example-litex-*-group"
                ;;
             *)
                echo "ERROR: Unknown example name: $example" >&2
                exit 1
                ;;
        esac
    done
# QuickLogic EOS-S3 examples
elif [ "$fpga_family" = "eos-s3" ]; then
    for example in $examples; do
        case $example in
            "counter")
                snippets="${snippets},eos-s3-counter"
                ;;
             *)
                echo "ERROR: Unknown example name: $example" >&2
                exit 1
                ;;
        esac
    done
else
  echo "ERROR: Unknown fpga_family: $fpga_family" >&2
  exit 1
fi

# call tuttest
tuttest_exec docs/building-examples.rst ${snippets}
