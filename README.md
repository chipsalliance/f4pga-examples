<p align="center">
  <a title="Website" href="https://f4pga.org"><img src="https://img.shields.io/website?longCache=true&style=flat-square&label=f4pga.org&up_color=10cfc9&url=https%3A%2F%2Ff4pga.org%2Findex.html&labelColor=fff"></a><!--
  -->
  <a title="Documentation" href="https://f4pga.readthedocs.io"><img src="https://img.shields.io/website?longCache=true&style=flat-square&label=Documentation&up_color=1226aa&up_message=%E2%9E%9A&url=https%3A%2F%2Ff4pga.readthedocs.io%2Fen%2Flatest%2Findex.html&labelColor=fff"></a><!--
  -->
  <a title="Community" href="https://f4pga.readthedocs.io/en/latest/community.html#communication"><img src="https://img.shields.io/badge/Chat-IRC%20%7C%20Slack-white?longCache=true&style=flat-square&logo=Slack&logoColor=fff"></a><!--
  -->
</p>

# F4PGA examples

<p align="center">
  <a title="GitHub Actions" href="https://github.com/chipsalliance/f4pga-examples/actions"><img src="https://img.shields.io/github/actions/workflow/status/chipsalliance/f4pga-examples/Automerge.yml?branch=main&longCache=true&style=flat-square&label=Tests&logo=Github%20Actions&logoColor=fff"></a><!--
  -->
  <a title="ReadTheDocs CI Status" href="https://f4pga-examples.readthedocs.io/en/latest/?badge=latest"><img alt="'Doc' workflow status" src="https://img.shields.io/readthedocs/f4pga-examples?longCache=true&style=flat-square&logo=ReadTheDocs&logoColor=fff&label=F4PGA%20Examples%20Documentation"></a><!--
  -->
</p>

This repository provides example FPGA designs that can be built using the F4PGA open source toolchain.
These examples target the Xilinx 7-Series and the QuickLogic EOS S3 devices.

* Please refer to the [![](https://img.shields.io/website?longCache=true&style=flat-square&label=Documentation%20For%20Users&up_color=231f20&up_message=%E2%9E%9A&url=https%3A%2F%2Ff4pga-examples.readthedocs.io%2Fen%2Flatest%2Findex.html&labelColor=fff)](https://f4pga-examples.readthedocs.io)
  for a proper guide on how to run these examples, as well as instructions on how to build and compile your own HDL designs using
  the F4PGA toolchain.
* See [![](https://img.shields.io/website?longCache=true&style=flat-square&label=Documentation%20For%20Developers&up_color=white&up_message=%E2%9E%9A&url=https%3A%2F%2Ff4pga.readthedocs.io%2Fprojects%2Farch-defs%2Fen%2Flatest%2Findex.html&labelColor=231f20)](https://f4pga.readthedocs.io/projects/arch-defs/)
  to contribute on the development of architecture support in F4PGA.

The repository includes:

* [xc7/](./xc7) and [eos-s3/](./eos-s3) - Examples for Xilinx 7-Series and EOS-S3 devices, including:

  * Verilog code

  * Pin constraints files

  * Timing constraints files

  * Makefiles for running the F4PGA toolchain

* [docs/](./docs) - Guide on how to get started with F4PGA and build provided examples

* [.github/](./.github) - Directory with CI configuration and scripts

The examples provided in this repository are automatically built and tested in CI by extracting necessary code snippets
with [tuttest](https://github.com/antmicro/tuttest).
