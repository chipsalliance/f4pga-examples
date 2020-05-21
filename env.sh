#!/bin/bash

# Activate conda environment
. ./env/conda/bin/activate symbiflow-env

# Setting symbiflow binaries path
SYMBIFLOW=$(pwd)/env/install/bin
export PATH=$SYMBIFLOW:${PATH}
