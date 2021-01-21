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
  echo "ERROR: Invalid number of arguments" >&2
  help >&2
  exit 1
fi

# -- tuttest ------------------------------------------------------------------

fpga_family=$1
os=$2

tuttest_exec docs/getting-symbiflow.rst:install-reqs-$os,wget-conda,conda-install-dir,fpga-fam-$fpga_family,conda-setup,download-arch-def-$fpga_family
