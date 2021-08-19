# Clock
 set_property PACKAGE_PIN W5 [get_ports { clk }]; 
 set_property IOSTANDARD LVCMOS33 [get_ports { clk }];

# Buttons 
 set_property PACKAGE_PIN U18 [get_ports { btnc }]; 
 set_property IOSTANDARD LVCMOS33 [get_ports { btnc }]; 
 
 set_property PACKAGE_PIN T18 [get_ports { btnu }]; 
 set_property IOSTANDARD LVCMOS33 [get_ports { btnu }];

# Seven-Segment Display
 set_property PACKAGE_PIN W7 [get_ports { segment[0] }]; 
 set_property PACKAGE_PIN W6 [get_ports { segment[1] }]; 
 set_property PACKAGE_PIN U8 [get_ports { segment[2] }]; 
 set_property PACKAGE_PIN V8 [get_ports { segment[3] }]; 
 set_property PACKAGE_PIN U5 [get_ports { segment[4] }]; 
 set_property PACKAGE_PIN V5 [get_ports { segment[5] }]; 
 set_property PACKAGE_PIN U7 [get_ports { segment[6] }]; 
 set_property PACKAGE_PIN V7 [get_ports { segment[7] }];

set_property IOSTANDARD LVCMOS33 [get_ports { segment[0] }];
set_property IOSTANDARD LVCMOS33 [get_ports { segment[1] }];
set_property IOSTANDARD LVCMOS33 [get_ports { segment[2] }];
set_property IOSTANDARD LVCMOS33 [get_ports { segment[3] }];
set_property IOSTANDARD LVCMOS33 [get_ports { segment[4] }];
set_property IOSTANDARD LVCMOS33 [get_ports { segment[5] }];
set_property IOSTANDARD LVCMOS33 [get_ports { segment[6] }];
set_property IOSTANDARD LVCMOS33 [get_ports { segment[7] }];

# Anodes
set_property PACKAGE_PIN U2 [get_ports { anode[0] }]; 
set_property PACKAGE_PIN U4 [get_ports { anode[1] }]; 
set_property PACKAGE_PIN V4 [get_ports { anode[2] }]; 
set_property PACKAGE_PIN W4 [get_ports { anode[3] }]; 

# Clock constraints
create_clock -period 10.0 [get_ports {clk}]