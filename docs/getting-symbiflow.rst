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

         apt update -y
         apt install -y git wget xz-utils

   .. group-tab:: CentOS

      .. code-block:: bash
         :name: install-reqs-centos

         yum update -y
         yum install -y git wget which xz


Next, clone the SymbiFlow examples repository and enter it:

.. code-block:: bash
   :name: get-symbiflow

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
   :name: conda-install-dir

   export INSTALL_DIR=~/opt/symbiflow

Toolchain
~~~~~~~~~

Select your target FPGA family:

.. tabs::

   .. group-tab:: Artix-7

      .. code-block:: bash
         :name: fpga-fam-xc7

         export FPGA_FAM=xc7

   .. group-tab:: EOS S3

      .. code-block:: bash
         :name: fpga-fam-eos-s3

         export FPGA_FAM=eos-s3

Next, setup Conda and your system's enviroment:

.. code-block:: bash
   :name: conda-setup

   bash conda_installer.sh -u -b -p $INSTALL_DIR/$FPGA_FAM/conda;
   source "$INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh";
   conda env create -f $FPGA_FAM/environment.yml

Download architecture definitions:

.. tabs::

   .. group-tab:: Artix-7

      .. code-block:: bash
         :name: download-arch-def-xc7

         mkdir -p $INSTALL_DIR/xc7/install;
         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/presubmit/install/1049/20201123-030526/symbiflow-arch-defs-install-05bd35c7.tar.xz | tar -xJC $INSTALL_DIR/xc7/install;
         mkdir -p $INSTALL_DIR/xc7/install/share/symbiflow/arch;
         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/presubmit/install/1049/20201123-030526/symbiflow-xc7a50t_test.tar.xz | tar -xJC $INSTALL_DIR/xc7/install/share/symbiflow/arch;
         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/presubmit/install/1049/20201123-030526/symbiflow-xc7a100t_test.tar.xz | tar -xJC $INSTALL_DIR/xc7/install/share/symbiflow/arch

   .. group-tab:: EOS-S3

      .. code-block:: bash
         :name: download-arch-def-eos-s3

         wget -qO- https://quicklogic-my.sharepoint.com/:u:/p/kkumar/EWuqtXJmalROpI2L5XeewMIBRYVCY8H4yc10nlli-Xq79g?download=1 | tar -xJ -C $INSTALL_DIR/eos-s3/

If the above commands exited without errors, you have successfuly installed and configured your working enviroment.

Build Example Designs
---------------------

With the toolchain installed, you can build the example designs.
The example designs are provided in separate directories:

* ``xc7`` directory for the Artix-7 devices
* ``eos-s3`` directory for the EOS S3 devices
