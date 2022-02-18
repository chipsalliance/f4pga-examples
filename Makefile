# Copyright 2019-2022 F4PGA Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

SHELL = bash

PYTHON_SRCS=$(shell find . -name "*.py" -not -path "./env/*" -not -path "./symbiflow/*")
JSON_SRCS=$(shell find . -name "*.json" -not -path "./env/*" -not -path "./symbiflow/*")
VERILOG_SRCS=$(shell find . -name "*.v" -not -path "./env/*" -not -path "./symbiflow/*")

env:
	conda env create -f environment.yml
	conda activate f4pga-examples

format:
	yapf -i ${PYTHON_SRCS}
	for i in ${JSON_SRCS}; do \
		echo "$$(mjson $$i)" > $$i; \
	done
	for i in ${VERILOG_SRCS}; do \
		echo "$$(verible-verilog-format $$i)" > $$i; \
	done

clean::
	rm -rf env/
	conda deactivate
	conda env remove -n f4pga-examples

.PHONY: env format clean
