ifdef F4PGA_USE_DEPRECATED
all:
# -d: Device
# -P: Part name
# -v: Verilog source
# -t: Top
# -p: PCF Constrains
	ql_symbiflow -compile \
	  -d ql-eos-s3 \
	  -P PD64 \
	  -v btn_counter.v \
	  -t top \
	  -p chandalar.pcf \
	  -dump openocd \
	  -dump header \
	  -dump binary
>>>>>>> 3d9062c (eos-s3/btn_counter/Makefile: dump jlink, openocd, header and binary)
else
all:
	f4pga -vvv build --flow ./flow.json
endif
