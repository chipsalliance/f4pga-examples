#!/bin/bash

# activate the environment
source activate eos-s3

# exec the cmd/command in this process, making it pid 1
exec "$@"