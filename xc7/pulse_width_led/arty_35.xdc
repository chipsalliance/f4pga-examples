
# Clock signal
set_property PACKAGE_PIN E3  [get_ports { clk }];
set_property IOSTANDARD LVCMOS33 [get_ports { clk }];

# Switches
set_property -dict { PACKAGE_PIN A8 IOSTANDARD LVCMOS33 } [get_ports { sw[0] }];
set_property -dict { PACKAGE_PIN C11 IOSTANDARD LVCMOS33 } [get_ports { sw[1] }];
set_property -dict { PACKAGE_PIN C10 IOSTANDARD LVCMOS33 } [get_ports { sw[2] }];
set_property -dict { PACKAGE_PIN A10 IOSTANDARD LVCMOS33 } [get_ports { sw[3] }];


# RGB LEDs
set_property -dict { PACKAGE_PIN E1 IOSTANDARD LVCMOS33 } [get_ports { pulse_blue }]; 
set_property -dict { PACKAGE_PIN F6 IOSTANDARD LVCMOS33 } [get_ports { pulse_green }]; 
set_property -dict { PACKAGE_PIN G6 IOSTANDARD LVCMOS33 } [get_ports { pulse_red }]; 

# Buttons
set_property -dict { PACKAGE_PIN D9 IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]; 
set_property -dict { PACKAGE_PIN C9 IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; 
set_property -dict { PACKAGE_PIN B9 IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; 
set_property -dict { PACKAGE_PIN B8 IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]; 


# CLK constraint
create_clock -period 10.0 [get_ports {clk}]