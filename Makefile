# Copyright (C) 2021  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

SHELL = bash

PYTHON_SRCS=$(shell find . -name "*.py" -not -path "./env/*" -not -path "./symbiflow/*")
JSON_SRCS=$(shell find . -name "*.json" -not -path "./env/*" -not -path "./symbiflow/*")
VERILOG_SRCS=$(shell find . -name "*.v" -not -path "./env/*" -not -path "./symbiflow/*")

env:
	conda env create -f environment.yml
	conda activate symbiflow-examples

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
	conda env remove -n symbiflow-examples

.PHONY: env format clean
