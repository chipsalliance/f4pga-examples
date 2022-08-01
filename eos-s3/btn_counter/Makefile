mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))
TOP:=top
VERILOG:=btn_counter.v
DEVICE := ql-eos-s3
PARTNAME := PD64
PCF:=chandalar.pcf

ifdef F4PGA_USE_DEPRECATED
all:
	ql_symbiflow -compile -d ${DEVICE} -P ${PARTNAME} -v ${VERILOG} -t ${TOP} -p ${PCF}
else
all:
	f4pga -vvv build --flow ./flow.json
endif
