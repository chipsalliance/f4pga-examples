Getting SymbiFlow
=================

This section describes how to install SymbiFlow and set up a fully working
environment to later build example designs.

Prerequisites
-------------

To be able to follow through this tutorial, install the following software:

.. tabs::

   .. group-tab:: Ubuntu

      .. code-block:: bash
         :name: install-reqs-ubuntu

         apt update -y
         apt install -y git wget xz-utils

   .. group-tab:: Debian

      .. code-block:: bash
         :name: install-reqs-debian

         apt update -y
         apt install -y git wget xz-utils

   .. group-tab:: CentOS

      .. code-block:: bash
         :name: install-reqs-centos

         ls -l /usr/share/zoneinfo
         find /usr/share/zoneinfo
         rm /usr/share/zoneinfo -rf
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

Download Conda installer script into the symbiflow-examples directory:

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

Next, setup Conda and your system's environment:

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

         mkdir -p $INSTALL_DIR/xc7/install
         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/459/20211116-000105/symbiflow-arch-defs-install-ef6fff3c.tar.xz | tar -xJC $INSTALL_DIR/xc7/install
         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/459/20211116-000105/symbiflow-arch-defs-xc7a50t_test-ef6fff3c.tar.xz | tar -xJC $INSTALL_DIR/xc7/install
         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/459/20211116-000105/symbiflow-arch-defs-xc7a100t_test-ef6fff3c.tar.xz | tar -xJC $INSTALL_DIR/xc7/install
         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/459/20211116-000105/symbiflow-arch-defs-xc7a200t_test-ef6fff3c.tar.xz | tar -xJC $INSTALL_DIR/xc7/install
         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/459/20211116-000105/symbiflow-arch-defs-xc7z010_test-ef6fff3c.tar.xz | tar -xJC $INSTALL_DIR/xc7/install

   .. group-tab:: EOS-S3

      .. code-block:: bash
         :name: download-arch-def-eos-s3

         wget -qO- https://storage.googleapis.com/symbiflow-arch-defs-install/quicklogic-arch-defs-63c3d8f9.tar.gz | tar -xz -C $INSTALL_DIR/eos-s3/

If the above commands exited without errors, you have successfully installed and configured your working environment.

Build Example Designs
---------------------

With the toolchain installed, you can build the example designs.
The example designs are provided in separate directories:

* ``xc7`` directory for the Artix-7 devices
* ``eos-s3`` directory for the EOS S3 devices
