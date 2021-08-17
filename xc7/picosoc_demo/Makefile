current_dir := ${CURDIR}
TOP := top
SOURCES := ${current_dir}/picosoc_noflash.v \
           ${current_dir}/picorv32.v \
           ${current_dir}/simpleuart.v \
           ${current_dir}/progmem.v

SDC := ${current_dir}/picosoc.sdc

ifeq ($(TARGET),arty_35)
  SOURCES += ${current_dir}/arty.v
  PCF := ${current_dir}/arty.pcf
else ifeq ($(TARGET),arty_100)
  SOURCES += ${current_dir}/arty.v
  PCF := ${current_dir}/arty.pcf
else ifeq ($(TARGET),nexys4ddr)
  SOURCES += ${current_dir}/nexys4ddr.v
  PCF := ${current_dir}/nexys4ddr.pcf
else
  SOURCES += ${current_dir}/basys3.v
  PCF := ${current_dir}/basys3.pcf
endif

include ${current_dir}/../../common/Makefile