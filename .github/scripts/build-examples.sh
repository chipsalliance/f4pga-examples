#!/bin/bash
#
# Copyright 2020-2022 F4PGA Authors
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
    examples="counter picosoc litex litex_linux litex_sata button_controller timer pulse_width_led hello-a"
elif [ "$fpga_family" == "eos-s3" -a -z "$examples" ]; then
    examples="counter"
fi


# activate conda and enter example dir
activate_env="docs/building-examples.rst:export-install-dir,fpga-fam-$fpga_family,conda-prep-env-$fpga_family,f4pga-env-bin,f4pga-env-share-$fpga_family,conda-act-env"
snippets="${activate_env},enter-dir-$fpga_family"
additionalDesigns="${activate_env},enter-dir-$fpga_family"


# Xilinx 7-Series examples
if [ "$fpga_family" = "xc7" ]; then
    for example in $examples; do
        case $example in
            "counter")
                snippets="${snippets} xc7/counter_test/README.rst:example-counter-*-group"
                ;;
            "picosoc")
                snippets="${snippets} xc7/picosoc_demo/README.rst:example-picosoc-*-group"
                ;;
            "litex")
                snippets="${snippets} xc7/litex_demo/README.rst:example-litex-dir,example-litex-req,example-litex_picorv32-*-group,example-litex_vexriscv-*-group"
                ;;
            "litex_linux")
                snippets="${snippets} xc7/linux_litex_demo/README.rst:example-litex-*-group"
                ;;
            "litex_sata")
                snippets="${snippets} xc7/litex_sata_demo/README.rst:example-litex-sata-*-group"
                ;;

            #Additional examples:
            "button_controller")
                snippets="${additionalDesigns} xc7/additional_examples/button_controller/README.rst:additional-examples,example-debouncer-basys3"
                ;;
            "pulse_width_led")
                snippets="${snippets} xc7/pulse_width_led/README.rst:example-pulse-arty-35t"
                ;;
            "timer")
                snippets="${snippets} xc7/timer/README.rst:example-watch-basys3"
                ;;

            # Project F examples
            "hello-a")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/A/README.rst:hello-arty-a"
                ;;
            "hello-b")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/B/README.rst:hello-arty-b"
                ;;
            "hello-c")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/C/README.rst:hello-arty-c"
                ;;
            "hello-d")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/D/README.rst:hello-arty-d"
                ;;
            "hello-e")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/E/README.rst:hello-arty-e"
                ;;
            "hello-f")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/F/README.rst:hello-arty-f"
                ;;
            "hello-g")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/G/README.rst:hello-arty-g"
                ;;
            "hello-h")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/H/README.rst:hello-arty-h"
                ;;
            "hello-i")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/I/README.rst:hello-arty-i"
                ;;
            "hello-j")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/J/README.rst:hello-arty-j"
                ;;
            "hello-k")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/K/README.rst:hello-arty-k"
                ;;
            "hello-l")
                snippets="${activate_env} projf-makefiles/hello/hello-arty/L/README.rst:hello-arty-l"
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
                snippets="${snippets} eos-s3/btn_counter/README.rst:eos-s3-counter"
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
tuttest_exec ${snippets}
