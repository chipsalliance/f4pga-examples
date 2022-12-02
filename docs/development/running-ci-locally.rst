Running CI locally
##################

The CI uses a bunch of scripts in the `.github/scripts/ <./.github/scripts>`_ directory to execute the needed tests.
You can use the same scripts locally to test without having to wait for the online CIs to pass if you want to quickly
test stuff.

For this, you will need `tuttest <https://github.com/antmicro/tuttest/>`_, which you can install with::

    pip install git+https://github.com/antmicro/tuttest

* ``<fpga-family>`` is one of ``{eos-s3, xc7, qlf_k4n8}`` (the three currently covered platforms - EOS-S3, K4N8 and Xilinx series 7).

* ``<os>`` is one of ``{ubuntu, debian, centos}`` (currently supported operating systems).

To install the toolchain (just the first time), run::

   .github/scripts/install-toolchain.sh <fpga-family> <os> | bash -c "$(cat /dev/stdin)"

To build all the examples locally, just run::

   .github/scripts/build-examples.sh <fpga-family>  | bash -c "$(cat /dev/stdin)"
