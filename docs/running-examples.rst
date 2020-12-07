Running example designs
========================

This section desribes how to properly connect your board.
It also helps you configure and run any other software that is necessary to observe results.

Connecting development boards
-----------------------------

Arty board
~~~~~~~~~~

#. Connect the board to your computer using the USB cable:
#. Connect the board to your computer using the Ethernet cable
   (only if you want to test the LiteX Linux Example)

.. image:: images/arty-usb-ethernet.png
   :width: 49%
   :align: center

Basys 3 board
~~~~~~~~~~~~~

Connect the Basys3 Board to your computer using the USB cable:

.. image:: images/basys3-usb.png
   :width: 49%
   :align: center

Zybo-Z7 board
~~~~~~~~~~~~~

Connect the Zybo-Z7 Board to your computer using the USB cable:

.. image:: images/zyboz7-usb.png
   :width: 49%
   :align: center

Insert the SD card in the dedicated slot:

.. image:: images/zyboz7-sdcard.png
   :width: 49%
   :align: center

.. _uart-connection:

Connecting to UART
------------------

First check available teletypes with:

.. code-block:: bash

   ls -l /dev | grep ttyUSB

You should see at least one, e.g.:

.. code-block:: bash

   crw-rw----+ 1 root  plugdev   188,   0 11-06 13:58 ttyUSB0
   crw-rw----+ 1 root  plugdev   188,   1 11-06 13:58 ttyUSB1

Simply use ``picocom`` to connect:

.. code-block:: bash

   picocom -b 115200 --imap lfcrlf /dev/ttyUSB1

.. warning::

   Substitute ``115200`` with the baud rate that your design uses!

.. warning::

   Please note that ``/dev/ttyUSB1`` is just an example. The number appearing may change!

.. note::

   If the picocom is unable to connect to any ``ttyUSBx`` device, you probably don't have appropriate user permissions.
   On Debian distributions, type the command below to add the user to the ``dialout`` group.
   This should resolve the missing permissions problem:

   .. code-block:: bash

      sudo usermod -a -G dialout `whoami`

Setting up TFTP
---------------

It is assumed that the server is running on port ``6069`` and uses ``/tftp`` directory.

#. Install tftp with (Ubuntu example):

   .. code-block:: bash

      sudo apt install tftpd-hpa

#. Create a directory for the server:

   .. code-block:: bash

      sudo mkdir -p /tftp
      sudo chmod 777 -R /tftp
      sudo chown tftp -R /tftp

#. Set up your TFTP configuration with:

   .. code-block:: bash

      cat << EOF | sudo tee /etc/default/tftpd-hpa
      TFTP_USERNAME="tftp"
      TFTP_DIRECTORY="/tftp"
      TFTP_ADDRESS=":6069"
      TFTP_OPTIONS="--secure"
      EOF

#. Restart the TFTP server:

   .. code-block:: bash

      sudo systemctl restart tftpd-hpa

Configuring your network interfaces
-----------------------------------

Check your network interfaces with:

.. code-block::

   ip link

Add IPv4 address to you interface:

.. code-block:: bash

   ip addr add 192.168.100.100/24 dev eth0

.. warning::

   ``192.169.100.100/24`` and ``eth0`` are just examples!

Setting up Zynq ARM CPU
------------------------

Zynq FPGAs include an ARM CPU. This guide instructs on setting up U-boot to run Linux, load bitstreams and control the Programmable Logic through the ARM CPU.

.. _prepare-sd:

Prepare SD card
~~~~~~~~~~~~~~~

#. Format the SD card by following the `official guide <https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842385/How+to+format+SD+card+for+SD+boot>`_.

#. Download and extract pre-built U-boot images

   .. code-block:: bash

      mkdir uboot-linux-images
      pushd uboot-linux-images
      wget -qO- https://github.com/SymbiFlow/symbiflow-xc7z-automatic-tester/releases/download/v1.0.0/uboot-linux-images.zip | bsdtar -xf-
      popd

#. Copy U-boot images to the boot mountpoint

   .. code-block:: bash

      cp uboot-linux-images/boot/* /path/to/mountpoint/boot/
      sync

#. Copy Arch Linux to the root mountpoint

   .. code-block:: bash

      wget -qO- http://de5.mirror.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz | sudo tar -xvzC /path/to/mountpoint/root
      sync

#. Copy additional files and binaries to the root directory in the Arch Linux filesystem

   .. code-block:: bash

      sudo cp -a uboot-linux-images/root/* /path/to/mountpoint/root/root/
      sync

.. note::

   ``/path/to/mountpoint`` is the path to the mounted SD card. If everything was set correctly in the formatting step, the ``boot`` and ``root`` directories should be under ``/media/<user>/``

.. note::

   ``/path/to/mountpoint/root`` contains the Arch Linux FileSystem, while ``/path/to/mountpoint/root/root/`` is a directory within the FileSystem itself.

.. warning::

   The ``sync`` step is crucial to let all the write buffers to complete the writing step on the SD card.

.. _uboot-load-bitstream:

Load bitstreams from U-boot
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Make sure to have :ref:`prepared the SD correctly<prepare-sd>`.

#. With the SD card inserted in the PC, copy the bitstream in the boot directory:
   
   .. code-block:: bash

      cp <name>.bit /path/to/mountpoint/boot
      sync

#. Set the jumper J5 to SD.

   .. image:: images/zyboz7-jmp.png
      :width: 49%
      :align: center

#. With the Zybo-Z7 connected insert the SD in the board's slot and switch on the board.

#. Connect to UART, see :ref:`uart-connection`.

#. Press the reset ``PS SRST`` button on the Zybo-Z7 and halt U-boot autoboot by pressing any key in the picocom terminal.

#. On the picocom terminal, you should have access to the U-boot terminal. Load the bitstream to memory:

   .. code-block:: bash

      Zynq> load mmc 0 0x10000000 <name>.bit

#. The size of the loaded bitstream appears on console:

   .. code-block:: bash

      <size> bytes read in 128 ms (15.5 MiB/s)

#. Load the bitstream to the FPGA:

   .. code-block:: bash

      Zynq> fpga loadb 0 0x10000000 <size>


Configure Arch Linux on Zynq
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Make sure to have :ref:`prepared the SD correctly<prepare-sd>`.

#. With the SD card inserted in the Zybo Z7 board, power up the board and :ref:`connect to it <uart-connection>`.

#. Halt the U-boot auto-booting process by pressing any key.

#. Set U-boot environment to correctly load Linux:

   .. code-block:: bash
      
      setenv bootargs "root=/dev/mmcblk0p2 rw rootwait"
      setenv bootcmd "load mmc 0 0x1000000 uImage && load mmc 0 0x2000000 devicetree.dtb && bootm 0x1000000 - 0x2000000"
      saveenv

#. Connect the bord to Internet, by connecting the Ethernet port to your router.

   .. image:: images/zyboz7-eth.png
      :width: 49%
      :align: center

#. Reset the device by pressing the ``PS SRST`` button on the board.

#. Login into Arch Linux with the following credentials:

   .. code-block:: bash

      user: root
      pass: root

#. Update the system with the following commands:

   .. code-block:: bash

      pacman-key --init
      pacman-key --populate
      pacman -Syu
