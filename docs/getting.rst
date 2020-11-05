Getting SymbiFlow
=================

Prerequisites
-------------

The only required prerequisite is ``wget``. You can install it using:

.. tabs::

   .. group-tab:: Ubuntu

      .. code-block:: bash
         :name: install-wget-ubuntu
        
         apt update && apt install -y wget

   .. group-tab:: CentOS

      .. code-block:: bash
         :name: install-wget-centos

         yum install -y wget

Toolchain installation
----------------------

This section describes how to install the toolchain. This procedure is divided in three steps:

- Installing the Conda package manager
- Choosing an installation directory
- Downloading the architecture definitions and installing the toolchain

Conda
~~~~~

.. code-block:: bash
   :name: wget-conda

   wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda_installer.sh

Choose the install directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The install directory can either be in your home directory
such as ``~/opt/symbiflow`` or in a system directory such as ``/opt/symbiflow``.
If you choose a system directory, you will need root permission to perform the installation,
and so you will need to add some ``sudo`` commands to the instructions below.

.. code-block:: bash

   INSTALL_DIR=~/opt/symbiflow

Toolchain
~~~~~~~~~

.. tabs::

   .. group-tab:: Artix-7

      .. code-block:: bash
         :name: xc7-setup-toolchain
        
         bash conda_installer.sh -b -p $INSTALL_DIR/xc7/conda
         source "$INSTALL_DIR/xc7/conda/etc/profile.d/conda.sh"
         conda env create -f xc7/environment.yml
         conda activate xc7
         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/66/20200914-111752/symbiflow-arch-defs-install-05d68df0.tar.xz | tar -xJ --one-top-level=$INSTALL_DIR/xc7/install
         conda deactivate

   .. group-tab:: EOS S3

      .. code-block:: bash
         :name: eos-s3-setup-toolchain
        
         bash conda_installer.sh -b -p $INSTALL_DIR/eos-s3/conda
         source "$INSTALL_DIR/eos-s3/conda/etc/profile.d/conda.sh"
         conda env create -f eos-s3/environment.yml
         conda activate eos-s3
         wget -qO- https://quicklogic-my.sharepoint.com/:u:/p/kkumar/EWuqtXJmalROpI2L5XeewMIBRYVCY8H4yc10nlli-Xq79g?download=1 | tar -xJ -C $INSTALL_DIR/eos-s3/
         conda deactivate


Build Example Designs
---------------------

With the toolchain installed, you can build the example designs.
The example designs are provided in separate directories:

* ``xc7`` directory for the Artix-7 devices
* ``eos-s3`` directory for the EOS S3 devices
