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

if [[ ! $# -ge 1 ]]; then
  echo "ERROR: Invalid number of arguments!" >&2
  echo "Please, provide: path/to/build-examples.sh <fpga_family> <example>..." >&2
  exit 1
fi

fpga_family=$1
shift

examples="$@"
if [ -z "$examples" ]; then
case "$fpga_family" in
  xc7)    examples="counter picosoc litex litex_linux litex_sata button_controller timer pulse_width_led hello-a" ;;
  eos-s3) examples="counter" ;;
esac
fi

# activate conda and enter example dir
activate_env="docs/building-examples.rst:export-install-dir,fpga-fam-$fpga_family,conda-env"
snippets="${activate_env},enter-dir-$fpga_family"

case "$fpga_family" in
  xc7) for example in $examples; do
    case $example in
      "counter")     tuttest ${snippets} xc7/counter_test/README.rst:example-counter-*-group ;;
      "picosoc")     tuttest ${snippets} xc7/picosoc_demo/README.rst:example-picosoc-*-group ;;
      "litex")       tuttest ${snippets} xc7/litex_demo/README.rst:example-litex-dir,example-litex-req,example-litex_picorv32-*-group,example-litex_vexriscv-*-group ;;
      "litex_linux") tuttest ${snippets} xc7/linux_litex_demo/README.rst:example-litex-*-group ;;
      "litex_sata")  tuttest ${snippets} xc7/litex_sata_demo/README.rst:example-litex-sata-*-group ;;

      #Additional examples:
      "button_controller") tuttest ${snippets} xc7/additional_examples/button_controller/README.rst:additional-examples,example-debouncer-basys3 ;;
      "pulse_width_led")   tuttest ${snippets} xc7/pulse_width_led/README.rst:example-pulse-arty-35t ;;
      "timer")             tuttest ${snippets} xc7/timer/README.rst:example-watch-basys3 ;;

      # Project F examples
      "hello") for helloexample in A B C D E F G H I J; do
        tuttest ${activate_env} projf-makefiles/hello/hello-arty/${helloexample}/README.rst:hello-arty-${helloexample,,}
      done ;;
      "hello-k") for helloexample in K L; do
        tuttest ${activate_env} projf-makefiles/hello/hello-arty/${helloexample}/README.rst:hello-arty-${helloexample,,}
      done ;;
      *) echo "ERROR: Unknown example name: $example" >&2
        exit 1 ;;
    esac
  done
  ;;
  eos-s3) for example in $examples; do
    case $example in
      "counter") tuttest ${snippets} eos-s3/btn_counter/README.rst:eos-s3-counter ;;
      *) echo "ERROR: Unknown example name: $example" >&2
        exit 1 ;;
    esac
  done
  ;;
  *) echo "ERROR: Unknown fpga_family: $fpga_family" >&2
    exit 1
  ;;
esac
