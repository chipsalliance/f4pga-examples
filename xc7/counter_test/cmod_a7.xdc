# Clock pin
set_property PACKAGE_PIN L17 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# LEDs
set_property PACKAGE_PIN A17  [get_ports {led[0]}]
set_property PACKAGE_PIN C16  [get_ports {led[1]}]
set_property PACKAGE_PIN B17  [get_ports {led[2]}]
set_property PACKAGE_PIN B16 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]

# Clock constraints (12 MHz oscillator)
create_clock -period 83.33 -waveform {0 41.66} [get_ports {clk}]
