# Clock pin
set_property LOC R4 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# LEDs
set_property LOC T14 [get_ports {led[0]}]
set_property LOC T15 [get_ports {led[1]}]
set_property LOC T16 [get_ports {led[2]}]
set_property LOC U16 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]

# Clock constraints
create_clock -period 8.0 [get_ports {clk}]
