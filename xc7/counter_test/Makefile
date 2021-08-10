current_dir := ${CURDIR}
TOP := top
SOURCES := ${current_dir}/counter.v

ifeq ($(TARGET),arty_35)
  DEVICE := xc7a50t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a35tcsg324-1
  XDC := ${current_dir}/arty.xdc
else ifeq ($(TARGET),arty_100)
  DEVICE := xc7a100t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a100tcsg324-1
  XDC := ${current_dir}/arty.xdc
else ifeq ($(TARGET),nexys4ddr)
  DEVICE := xc7a100t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a100tcsg324-1
  XDC := ${current_dir}/nexys4ddr.xdc
else ifeq ($(TARGET),zybo)
  DEVICE := xc7z010_test
  BITSTREAM_DEVICE := zynq7
  PARTNAME := xc7z010clg400-1
  XDC := ${current_dir}/zybo.xdc
  SOURCES:=${current_dir}/counter_zynq.v
else ifeq ($(TARGET),nexys_video)
  DEVICE := xc7a200t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a200tsbg484-1
  XDC := ${current_dir}/nexys_video.xdc
else
  DEVICE := xc7a50t_test
  BITSTREAM_DEVICE := artix7
  PARTNAME := xc7a35tcpg236-1
  XDC := ${current_dir}/basys3.xdc
endif

export

all:
	cd ../../common && $(MAKE)
clean:
	cd ../../common && $(MAKE) clean    

