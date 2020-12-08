#!/bin/bash
set -e

fpga_fam=$1
shift

# select particular example for xc7
examples="$@"
if [ "$fpga_fam" == "xc7" -a -z "$examples" ] ; then
    examples="counter picosoc linux_litex"
fi;

# activate conda and enter example dir
eval $(tuttest docs/building-examples.rst export-install-dir 2>&1)
eval $(tuttest docs/building-examples.rst fpga-fam-$fpga_fam 2>&1)
eval $(tuttest docs/building-examples.rst conda-prep-env 2>&1)
eval $(tuttest docs/building-examples.rst conda-act-env 2>&1)
eval $(tuttest docs/building-examples.rst enter-dir-$fpga_fam 2>&1)

if [ "$fpga_fam" = "xc7" ]; then
    # Xilinx 7-Series examples
    for example in $examples; do
        case $example in
            "counter")
                eval $(tuttest counter_test/README.rst example-counter-a35t-group 2>&1)
                eval $(tuttest counter_test/README.rst example-counter-a100t-group 2>&1)
                eval $(tuttest counter_test/README.rst example-counter-basys3-group 2>&1)
                ;;
            "picosoc")
                eval $(tuttest picosoc_demo/README.rst example-picosoc-basys3-group 2>&1)
                ;;
            "linux_litex")
                eval $(tuttest linux_litex_demo/README.rst example-litex-deps 2>&1)
                eval $(tuttest linux_litex_demo/README.rst example-litex-a35t-group 2>&1)
                eval $(tuttest linux_litex_demo/README.rst example-litex-a100t-group 2>&1)
                ;;
        esac
    done
else
    # QuickLogic EOS-S3 examples
    eval $(tuttest btn_counter/README.rst eos-s3-counter 2>&1)
fi;
