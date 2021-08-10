current_dir := ${CURDIR}
TOP := top
SOURCES := ${current_dir}/picosoc_noflash.v \
           ${current_dir}/picorv32.v \
           ${current_dir}/simpleuart.v \
           ${current_dir}/progmem.v

SDC := ${current_dir}/picosoc.sdc
BITSTREAM_DEVICE := artix7

ifeq ($(TARGET),arty_35)
  DEVICE  := xc7a50t_test
  SOURCES += ${current_dir}/arty.v
  PARTNAME := xc7a35tcsg324-1
  PCF := ${current_dir}/arty.pcf
else ifeq ($(TARGET),arty_100)
  DEVICE := xc7a100t_test
  SOURCES += ${current_dir}/arty.v
  PARTNAME := xc7a100tcsg324-1
  PCF := ${current_dir}/arty.pcf
else ifeq ($(TARGET),nexys4ddr)
  DEVICE := xc7a100t_test  
  SOURCES += ${current_dir}/nexys4ddr.v
  PARTNAME := xc7a100tcsg324-1
  PCF := ${current_dir}/nexys4ddr.pcf
else
  DEVICE  := xc7a50t_test
  SOURCES += ${current_dir}/basys3.v
  PARTNAME := xc7a35tcpg236-1
  PCF := ${current_dir}/basys3.pcf
endif

export

all:
	cd ../../common && $(MAKE)

clean:
	cd ../../common && $(MAKE) clean 