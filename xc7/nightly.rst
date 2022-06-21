Obtaining nightly version of the tools
======================================

Sometimes it may be preferable to get the latest versions of the tools even before the full Toolchain is validated and upgraded. These tools **are not guaranteered to be bug free**, but they enable users to take advantage of the latest fixes available.

Updating Yosys SystemVerilog plugin
-----------------------------------

Make sure :code:`curl`, :code:`jq`, :code:`tar` and :code:`wget` are installed (used to automatically download newest version):

.. code-block:: bash
   :name: activate-xc7

   apt install curl jq tar wget

Activate the conda repository for the correct family:

.. code-block:: bash
   :name: activate-xc7

   conda activate xc7

Obtain the latest release of the plugin from `here <https://github.com/antmicro/yosys-uhdm-plugin-integration/releases>`_:

.. code-block:: bash
   :name: get-plugin

   curl https://api.github.com/repos/antmicro/yosys-uhdm-plugin-integration/releases/latest | jq .assets[1] | grep "browser_download_url" | grep -Eo 'https://[^\"]*' | xargs wget -O - | tar -xz

Install the plugin using provided installation script. It will use the `yosys-config` from conda, so it will install into the conda environment.

.. code-block:: bash
   :name: install-plugin

   ./install-plugin.sh
