#!/bin/bash
set -e

distro=$1
distro_ver=$2

# install required packages
if [ "$distro" == "ubuntu" ]; then
    apt update -y
    apt install -y git wget

    # if running on xenial, install newer python version from ppa
    if [ "$distro_ver" == "xenial" ]; then
        apt install -y software-properties-common
        add-apt-repository -y ppa:deadsnakes/ppa
        apt update -y
        apt install -y python3.6 python3.6-dev python3.6-venv
        update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
        update-alternatives --set python /usr/bin/python3.6

        wget https://bootstrap.pypa.io/get-pip.py
        python3.6 get-pip.py
    else
        apt install -y python3-pip python3-setuptools
    fi
else
    yum update -y
    yum install -y python3-pip python3-setuptools git wget which
fi

# install python deps
pip3 install dataclasses
pip3 install git+https://github.com/antmicro/tuttest
