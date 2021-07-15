

# Clock
 set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports { clk }];
 create_clock -period 10.0 [get_ports {clk}]

# Buttons 
 set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports { btnc }]; 
 set_property -dict { PACKAGE_PIN T18 IOSTANDARD LVCMOS33 } [get_ports { btnu }]; 


# Switches
 set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]; 
 set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]; 
 set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS33 } [get_ports { sw[2] }]; 
 set_property -dict { PACKAGE_PIN W17 IOSTANDARD LVCMOS33 } [get_ports { sw[3] }]; 
 set_property -dict { PACKAGE_PIN W15 IOSTANDARD LVCMOS33 } [get_ports { sw[4] }]; 
 set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { sw[5] }]; 
 set_property -dict { PACKAGE_PIN W14 IOSTANDARD LVCMOS33 } [get_ports { sw[6] }]; 
 set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports { sw[7] }]; 

# Seven Segment Display
 set_property -dict { PACKAGE_PIN W7 IOSTANDARD LVCMOS33 } [get_ports { segment[0] }]; 
 set_property -dict { PACKAGE_PIN W6 IOSTANDARD LVCMOS33 } [get_ports { segment[1] }]; 
 set_property -dict { PACKAGE_PIN U8 IOSTANDARD LVCMOS33 } [get_ports { segment[2] }]; 
 set_property -dict { PACKAGE_PIN V8 IOSTANDARD LVCMOS33 } [get_ports { segment[3] }]; 
 set_property -dict { PACKAGE_PIN U5 IOSTANDARD LVCMOS33 } [get_ports { segment[4] }]; 
 set_property -dict { PACKAGE_PIN V5 IOSTANDARD LVCMOS33 } [get_ports { segment[5] }]; 
 set_property -dict { PACKAGE_PIN U7 IOSTANDARD LVCMOS33 } [get_ports { segment[6] }]; 
 set_property -dict { PACKAGE_PIN V7 IOSTANDARD LVCMOS33 } [get_ports { segment[7] }]; 
 set_property -dict { PACKAGE_PIN U2 IOSTANDARD LVCMOS33 } [get_ports { anode[0] }]; 
 set_property -dict { PACKAGE_PIN U4 IOSTANDARD LVCMOS33 } [get_ports { anode[1] }]; 
 set_property -dict { PACKAGE_PIN V4 IOSTANDARD LVCMOS33 } [get_ports { anode[2] }]; 
 set_property -dict { PACKAGE_PIN W4 IOSTANDARD LVCMOS33 } [get_ports { anode[3] }]; 

# UART
set_property -dict { PACKAGE_PIN A18 IOSTANDARD LVCMOS33 } [get_ports { tx_out }]; 
set_property -dict { PACKAGE_PIN J1 IOSTANDARD LVCMOS33 } [get_ports { tx_debug }]; 

