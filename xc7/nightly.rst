Obtaining nightly version of the tools
======================================

Sometimes it may be preferable to get the latest versions of the tools even beforethe full Toolchain is validated and upgraded. These tools **are not guaranteered to be bug free**, but they enable users to take advantage of the latest fixes available.

Updating Yosys SystemVerilog plugin
-----------------------------------

Activate the conda repository for the correct family:

.. code-block:: bash
   :name: activate-xc7

   conda activate xc7

Obtain the latest release of the plugin from `here <https://github.com/antmicro/yosys-uhdm-plugin-integration/releases>`_:

.. code-block:: bash
   :name: get-plugin

   wget https://github.com/antmicro/yosys-uhdm-plugin-integration/releases/download/e3a87e3-2022-06-17/yosys-uhdm-plugin-e3a87e3-Ubuntu-20.04-focal-x86_64.tar.gz
   tar -xzf yosys-uhdm-plugin-e3a87e3-Ubuntu-20.04-focal-x86_64.tar.gz

Install the plugin using provided installation script. It will use the `yosys-config` from conda, so it will install into the conda environment.

.. code-block:: bash
   :name: install-plugin

   ./install-plugin.sh
