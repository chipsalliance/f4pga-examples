#!/bin/bash

function tuttest_exec() {
cat << EOF
  echo
  echo "==================================================================== "
  echo "OUTPUT : tuttest $@"
  echo "EXECUTED COMMAND:"
  echo
  echo '$(tuttest $@)'
  echo "-------------------------------------------------------------------- "
  echo
EOF
  tuttest "$@"
}
