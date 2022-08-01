ifdef F4PGA_USE_DEPRECATED
all:
	ql_symbiflow \
	  -compile \
	  -d ql-eos-s3 \
	  -P PD64 \
	  -v btn_counter.v \
	  -t top \
	  -p chandalar.pcf
else
all:
	f4pga -vvv build --flow ./flow.json
endif
