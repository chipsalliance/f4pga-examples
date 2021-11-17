current_dir := ${CURDIR}
TOP := top
SOURCES := ${current_dir}/counter.v

ifeq ($(TARGET),arty_35)
  XDC := ${current_dir}/arty.xdc
else ifeq ($(TARGET),arty_100)
  XDC := ${current_dir}/arty.xdc
else ifeq ($(TARGET),nexys4ddr)
  XDC := ${current_dir}/nexys4ddr.xdc
else ifeq ($(TARGET),zybo)
  XDC := ${current_dir}/zybo.xdc
  SOURCES:=${current_dir}/counter_zynq.v
else ifeq ($(TARGET),nexys_video)
  XDC := ${current_dir}/nexys_video.xdc
else
  XDC := ${current_dir}/basys3.xdc
endif

include ${current_dir}/../../common/common.mk

