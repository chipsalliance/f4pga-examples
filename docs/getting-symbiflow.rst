Getting SymbiFlow
=================

This section describe how to install SymbiFlow and setup a fully working
enviroment to later build example desings.

Prerequisites
-------------

To be able to follow through this tutorial, install the following software:

.. tabs::

   .. group-tab:: Ubuntu

      .. code-block:: bash
         :name: install-reqs-ubuntu
        
         apt install -y git wget picocom

   .. group-tab:: CentOS

      .. code-block:: bash
         :name: install-reqs-centos

         yum install -y git wget picocom

   .. group-tab:: Arch

      .. code-block:: bash
         :name: install-reqs-arch

         pacman -Sy git wget picocom

Next, clone the SymbiFlow examples repository and enter it:

.. code-block:: bash

    git clone https://github.com/SymbiFlow/symbiflow-examples
    cd symbiflow-examples

Toolchain installation
----------------------

Now we are able to install the SymbiFlow toolchain. This procedure is divided
into three steps:

- installing the Conda package manager,
- choosing an installation directory,
- downloading the architecture definitions and installing the toolchain.

Conda
~~~~~

Download Conda installer script:

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

Select your target FPGA family:

.. tabs::

    .. group-tab:: Artix-7

        .. code-block:: bash

            FPGA_FAM=xc7

    .. group-tab:: EOS S3

        .. code-block:: bash

            FPGA_FAM=eos-s3

Next, setup Conda and your system's enviroments:

.. code-block:: bash

    bash conda_installer.sh -b -p $INSTALL_DIR/$FPGA_FAM/conda
    source "$INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh"
    conda env create -f examples/$FPGA_FAM/environment.yml

Activate your Conda enviroment:

.. code-block:: bash

    conda activate $FPGA_FAM

Download architecture definitions

.. tabs::

   .. group-tab:: Artix-7

      .. code-block:: bash

         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/66/20200914-111752/symbiflow-arch-defs-install-05d68df0.tar.xz | tar -xJ --one-top-level=$INSTALL_DIR/xc7/install

   .. group-tab:: EOS-S3

      .. code-block:: bash

         wget -qO- https://quicklogic-my.sharepoint.com/:u:/p/kkumar/EWuqtXJmalROpI2L5XeewMIBRYVCY8H4yc10nlli-Xq79g?download=1 | tar -xJ -C $INSTALL_DIR/eos-s3/

You have successfuly installed and configured your working enviroment. For now, you can safely deactivate it with:

.. code-block:: bash

    conda deactivate


Build Example Designs
---------------------

With the toolchain installed, you can build the example designs.
The example designs are provided in separate directories:

* ``xc7`` directory for the Artix-7 devices
* ``eos-s3`` directory for the EOS S3 devices
