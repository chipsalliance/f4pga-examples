#!/bin/bash

# activate the environment
source activate xc7

# exec the cmd/command in this process, making it pid 1
exec "$@"